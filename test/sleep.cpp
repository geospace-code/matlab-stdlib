#include <chrono>
#include <thread>

#include <cstdlib>
#include <iostream>


int main(int argc, char *argv[]) {

    int milliseconds = (argc > 1) ? std::atoi(argv[1]) : 2000;

    std::cout << "Sleeping for " << milliseconds << " milliseconds..." << std::endl;

    std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));

    std::cout << "Awake!" << std::endl;

    return EXIT_SUCCESS;
}
