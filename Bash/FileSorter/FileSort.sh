#!/bin/bash

RULES_FILE="./.filesort_rules"
SOURCES_FILE="./.filesort_sources"
LOG_FILE="./filesort_log"
PID_FILE="/tmp/filesort_daemon.pid"
TIMER_FILE="./.filesort_timer"
DEFAULT_INTERVAL=600

# Default sources if none added
DEFAULT_SOURCES=("$HOME/Desktop/" "$HOME/Downloads/")

# Initialize files if they don't exist
init_files() {
    [[ ! -f "$RULES_FILE" ]] && touch "$RULES_FILE"
    [[ ! -f "$SOURCES_FILE" ]] && touch "$SOURCES_FILE"
}
init_files

# Load current sources (or fallback to defaults)
load_sources() {
    if [[ -s "$SOURCES_FILE" ]]; then
        mapfile -t WATCH_DIRS < "$SOURCES_FILE"
    else
        WATCH_DIRS=("${DEFAULT_SOURCES[@]}")
    fi
}

# Replace rule for given extension
replace_rule() {
    local ext="$1"
    local dest="$2"
    echo "$ext $dest" > "$RULES_FILE.tmp"

    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ "${line%% *}" == "$ext" ]] && continue
        echo "$line" >> "$RULES_FILE.tmp"
    done < "$RULES_FILE"

    mv "$RULES_FILE.tmp" "$RULES_FILE"
    echo "Rule replaced: $ext -> $dest"
}

# Add rule to rule list (calls replace if exists)
add_rule() {
    local ext="$1"
    local dest="$2"
    mkdir -p "$dest"

    if grep -q "^$ext " "$RULES_FILE"; then
        echo "A rule for '$ext' already exists:"
        grep "^$ext " "$RULES_FILE"
        read -p "Do you want to replace it? [Y/N]: " confirm
        case "$confirm" in
            [Yy]* )
                replace_rule "$ext" "$dest"
                ;;
            * )
                echo "Operation cancelled."
                return
                ;;
        esac
    else
        echo "$ext $dest" >> "$RULES_FILE"
        echo "Rule added: $ext -> $dest"
    fi
}

# Delete rule by extension
del_rule() {
    local ext="$1"
    local found=0
    local tmpfile
    tmpfile=$(mktemp)

    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "${line%% *}" == "$ext" ]]; then
            found=1
            continue
        fi
        echo "$line" >> "$tmpfile"
    done < "$RULES_FILE"

    if [[ $found -eq 1 ]]; then
        mv "$tmpfile" "$RULES_FILE"
        echo "Rule for '$ext' deleted."

        # If the rules file is now empty, show the message
        if [[ ! -s "$RULES_FILE" ]]; then
            echo "No rules defined yet." > "$RULES_FILE"
            # optional: truncate the file instead with > "$RULES_FILE"
        fi
    else
        rm -f "$tmpfile"
        echo "No rule found for extension: $ext"
    fi
}

# Add source to source list
add_source() {
    local dir="$1"
    if [[ -d "$dir" ]]; then
        if grep -Fxq "$dir" "$SOURCES_FILE"; then
            echo "Source directory already exists: $dir"
        else
            echo "$dir" >> "$SOURCES_FILE"
            echo "Source directory added: $dir"
        fi
    else
        echo "Invalid directory: $dir"
    fi
}

# Delete source from source list
del_source() {
    local dir="$1"
    if [[ ! -f "$SOURCES_FILE" ]]; then
        echo "No sources file found."
        return
    fi

    local tmpfile
    tmpfile=$(mktemp)
    local found=0

    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "$dir" ]]; then
            found=1
            continue
        fi
        echo "$line" >> "$tmpfile"
    done < "$SOURCES_FILE"

    if [[ $found -eq 1 ]]; then
        mv "$tmpfile" "$SOURCES_FILE"
        echo "Source directory removed: $dir"
    else
        rm -f "$tmpfile"
        echo "Source directory not found: $dir"
    fi
}


# List sources from source file
list_sources() {
    if [[ -s "$SOURCES_FILE" ]]; then
        echo "Current source directories:"
        cat "$SOURCES_FILE"
    else
        echo "Using default sources:"
        printf "%s\n" "${DEFAULT_SOURCES[@]}"
    fi
}

# List rules from rules file
list_rules() {
    if [[ -s "$RULES_FILE" ]]; then
        echo "Current sort rules:"
        cat "$RULES_FILE"
    else
        echo "No rules defined yet."
    fi
}

# One time run
run_once() {
    [[ ! -s "$RULES_FILE" ]] && return
    load_sources

    while read -r ext dest; do
        for dir in "${WATCH_DIRS[@]}"; do
            find "$dir" -maxdepth 1 -type f -not -name ".*" -name "*$ext" | while read -r file; do
                basefile=$(basename "$file")
                if mv -n "$file" "$dest/$basefile"; then
                    echo "$(date '+%Y-%m-%d %H:%M:%S') $basefile $dir $dest" >> "$LOG_FILE"
                fi
            done
        done
    done < "$RULES_FILE"
}

# Start daemon if not yet started
start_daemon() {
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        echo "Daemon already running (PID $(cat "$PID_FILE"))."
        return
    fi

    local interval="$DEFAULT_INTERVAL"
    [[ -f "$TIMER_FILE" ]] && interval=$(<"$TIMER_FILE")

    (
        while true; do
            run_once
            sleep "$interval"
        done
    ) &
    echo $! > "$PID_FILE"
    echo "Daemon started (PID $!) with interval: ${interval}s."
}

set_timer() {
    local seconds="$1"
    if [[ "$seconds" =~ ^[0-9]+$ && "$seconds" -ge 1 ]]; then
        echo "$seconds" > "$TIMER_FILE"
        echo "Timer interval set to $seconds seconds."
    else
        echo "Invalid interval: must be a positive integer (in seconds)."
    fi
}

# Stop daemon if running
stop_daemon() {
    if [[ -f "$PID_FILE" ]]; then
        kill "$(cat "$PID_FILE")" && rm -f "$PID_FILE"
        echo "Daemon stopped."
    else
        echo "Daemon not running."
    fi
}

# Help screen
show_help() {
    cat << EOF
FileSort - Auto-sort files by extension

USAGE:
  ./filesort <command> [args...]

COMMANDS:
  addrule <.ext> <destination>       Add sort rule: moves *.ext files to destination
  delrule <.ext>                     Delete sorting rule for a given extension
  addsource <dir>                    Add a source directory to scan
  delsource <dir>                    Remove a source directory from list
  listsource                         List all source directories
  listrules                          List all sorting rules
  run                                Start background daemon (runs every 10 minutes)
  stop                               Stop background daemon
  timer <seconds>                    Set how often the script runs (default: 600 seconds)

  help                               Show this help screen

LOGGING:
  All moved files are logged in: $LOG_FILE

EXAMPLE:
  ./filesort addrule .pdf /home/user/docs
  ./filesort addsource /mnt/shared
  ./filesort run
EOF
}

# Main CLI interface (switchboard)
case "$1" in
    addrule)
        [[ $# -ne 3 ]] && show_help && exit 1
        add_rule "$2" "$3"
        ;;
    delrule)
        [[ $# -ne 2 ]] && show_help && exit 1
        del_rule "$2"
        ;;
    addsource)
        [[ $# -ne 2 ]] && show_help && exit 1
        add_source "$2"
        ;;
    delsource)
        [[ $# -ne 2 ]] && show_help && exit 1
        del_source "$2"
        ;;
    listsource)
        list_sources
        ;;
    listrules)
        list_rules
        ;;
    run)
        start_daemon
        ;;
    stop)
        stop_daemon
        ;;
    timer)
        [[ $# -ne 2 ]] && show_help && exit 1
        set_timer "$2"
        ;;
    help|"")
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        ;;
esac