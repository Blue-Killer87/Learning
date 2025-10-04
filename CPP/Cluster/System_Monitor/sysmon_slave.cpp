// Slave part of a Cluster System monitor. 
// Run on each slave node, must be in same LAN as master node (with its master script running).

#include <iostream>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <ctime>

using namespace std;

string run_command(const string& cmd) {
    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return "[error]";
    char buffer[1024];
    stringstream result;
    while (fgets(buffer, sizeof(buffer), pipe)) result << buffer;
    pclose(pipe);
    return result.str();
}

int main() {
    // Hostname & uptime
    cout << "[Hostname & Uptime]\n";
    cout << run_command("hostname");
    cout << run_command("uptime -p");

    // CPU Load
    cout << "[CPU Load]   ";
    cout << run_command("cut -d ' ' -f1 /proc/loadavg");

    // Memory
    cout << "[Memory]     ";
    cout << run_command("free -m | awk '/Mem:/ {printf \"%d%% used (%dMB / %dMB)\\n\", ($2-$7)*100/$2, $2-$7, $2}'");

    // Temp
    cout << "[Temp]       ";
    cout << run_command("awk '{printf \"%.1f°C\\n\", $1/1000}' /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo N/A");

    // Storage
    cout << "[Storage]\n";
    cout << run_command("df -h --output=source,size,used,avail,target | grep -v tmpfs");

    // Network
    cout << "[Network Interfaces]\n";
    cout << run_command("ip -o -4 addr show | awk '{print $2, $4}'");

    // Timestamp
    time_t now = time(nullptr);
    cout << "\nReport generated: " << ctime(&now);

    return 0;
}
