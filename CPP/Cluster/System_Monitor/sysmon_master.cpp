// Master part of a cluster System Monitor.
// Run strictly on Master, must be in the same LAN.

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <map>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <ctime>

#define PORT 1933
#define CONFIG_FILE "/bin/node.conf"

using namespace std;

string trim(const string& str) {
    size_t first = str.find_first_not_of(" \t\n");
    if (first == string::npos) return "";
    size_t last = str.find_last_not_of(" \t\n");
    return str.substr(first, last - first + 1);
}

map<string, string> loadNodeList() {
    map<string, string> nodes;
    ifstream infile(CONFIG_FILE);
    if (!infile) return nodes;

    string line;
    while (getline(infile, line)) {
        line = trim(line);
        if (line.empty() || line[0] == '#') continue;
        size_t eq = line.find('=');
        if (eq == string::npos) continue;
        string name = trim(line.substr(0, eq));
        string ip = trim(line.substr(eq + 1));
        if (!name.empty() && !ip.empty()) nodes[name] = ip;
    }
    return nodes;
}

string run_command(const string& cmd) {
    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return "[error]";
    char buffer[1024];
    stringstream result;
    while (fgets(buffer, sizeof(buffer), pipe)) result << buffer;
    pclose(pipe);
    return result.str();
}

string getLocalSysinfo() {
    stringstream ss;
    ss << "🖥️  === Master Node ===\n";

    // Hostname and uptime
    ss << "[Hostname & Uptime]\n";
    ss << run_command("hostname");
    ss << run_command("uptime -p");

    // CPU Load
    ss << "[CPU Load]   ";
    ss << run_command("cut -d ' ' -f1 /proc/loadavg");

    // Memory
    ss << "[Memory]     ";
    ss << run_command("free -m | awk '/Mem:/ {printf \"%d%% used (%dMB / %dMB)\\n\", ($2-$7)*100/$2, $2-$7, $2}'");

    // Temp
    ss << "[Temp]       ";
    ss << run_command("awk '{printf \"%.1f°C\\n\", $1/1000}' /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo N/A");

    // Storage
    ss << "[Storage]\n";
    ss << run_command("df -h --output=source,size,used,avail,target | grep -v tmpfs");

    // Network
    ss << "[Network Interfaces]\n";
    ss << run_command("ip -o -4 addr show | awk '{print $2, $4}'");

    // Timestamp
    time_t now = time(nullptr);
    ss << "\n[i] Report generated: " << ctime(&now);

    return ss.str();
}

string queryNode(const string& ip) {
    int sockfd;
    struct sockaddr_in serv_addr;
    struct hostent *server;

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) return "[error: could not open socket]";
    server = gethostbyname(ip.c_str());
    if (!server) return "[error: no such host]";

    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    memcpy(&serv_addr.sin_addr.s_addr, server->h_addr, server->h_length);
    serv_addr.sin_port = htons(PORT);

    if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        close(sockfd);
        return "[error: connection failed]";
    }

    string request = "sysinfo\n";
    write(sockfd, request.c_str(), request.length());

    char buffer[4096];
    stringstream response;
    int n;
    while ((n = read(sockfd, buffer, sizeof(buffer)-1)) > 0) {
        buffer[n] = 0;
        response << buffer;
    }

    close(sockfd);
    return response.str();
}

int main() {
    cout << "[i] Cluster Monitor\n";
    cout << "==============================\n";

    auto nodes = loadNodeList();

    if (nodes.empty()) {
        cout << "! No nodes listed in /bin/node.conf\n";
        cout << "! Run discovery with: sudo ./autodiscover.sh\n\n";
    }

    cout << getLocalSysinfo() << "\n";

    for (const auto& [name, ip] : nodes) {
        cout << "🔹 " << name << " (" << ip << ")\n";
        cout << queryNode(ip);
        cout << "------------------------------\n";
    }

    return 0;
}
