// === mainnode.cpp ===
// This will run on the MasterNode. It sends command to given IP and listens for results. (operated by sendjob script or directly via binary of this program)


#include <iostream>
#include <string>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>

int main(int argc, char* argv[]) {
    if (argc < 3) {
        std::cerr << "Usage: " << argv[0] << " <slave_ip> <command>\n";
        return 1;
    }

    const char* slave_ip = argv[1];
    int port = 1933;
    std::string command = argv[2];
    for (int i = 3; i < argc; ++i) {
        command += " ";
        command += argv[i];
    }

    

    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        perror("Socket creation failed");
        return 1;
    }

    sockaddr_in server_addr{};
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(port);

    if (inet_pton(AF_INET, slave_ip, &server_addr.sin_addr) <= 0) {
        std::cerr << "Invalid IP address\n";
        return 1;
    }

    if (connect(sock, (sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Connection failed");
        return 1;
    }

    send(sock, command.c_str(), command.size(), 0);

    char buffer[4096];
    ssize_t bytes_received;
    while ((bytes_received = recv(sock, buffer, sizeof(buffer) - 1, 0)) > 0) {
        buffer[bytes_received] = '\0';
        std::cout << buffer;
    }

    close(sock);
    return 0;
}



