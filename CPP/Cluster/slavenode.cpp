// === slavenode.cpp ===
// This will run on the SlaveNode. It listens on a TCP port and executes received commands.

#include <iostream>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <cstring>
#include <cstdlib>

#define PORT 1933
#define BUFFER_SIZE 1024

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    char buffer[BUFFER_SIZE] = {0};

    // Create socket
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // Attach socket to the port
    setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    listen(server_fd, 3);
    std::cout << "[Slave] Listening on port " << PORT << "..." << std::endl;
    
    while (true) {
        new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
        if (new_socket < 0) {
            perror("accept");
            continue;
        }


        memset(buffer, 0, BUFFER_SIZE);
        read(new_socket, buffer, BUFFER_SIZE);
        std::cout << "[Slave] Received command: " << buffer << std::endl;

        // Execute the command and get outputs
        FILE* pipe = popen(buffer, "r");
        if (!pipe) {
            std::string error = "Failed to run command\n";
            send(new_socket, error.c_str(), error.size(), 0);
        } else {
            char result[BUFFER_SIZE];
            while (fgets(result, sizeof(result), pipe) != nullptr) {
                send(new_socket, result, strlen(result), 0);
            }
            pclose(pipe);
        }
        close(new_socket);
    }
    return 0;
}


