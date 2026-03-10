#include <chrono>
#include <thread>

#include <cstdlib>
#include <iostream>


int main(int argc, char *argv[]) {

    int milliseconds = (argc > 1) ? std::atoi(argv[1]) : 2000;

    std::cout << "Sleeping for " << milliseconds << " milliseconds...\n";

    std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));

    std::cout << "Awake!\n";

    return EXIT_SUCCESS;
}
