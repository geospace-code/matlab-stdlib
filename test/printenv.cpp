#include <cstdlib>
#include <iostream>

#ifdef _MSC_VER
#pragma warning(disable : 4996)
#endif


int main(int argc, char *argv[]) {

  if (argc < 2) {
    std::cerr << "Specify environment variable name to print\n";
    return EXIT_FAILURE;
  }

  char *value = std::getenv(argv[1]);

  if (value) {
    std::cout << value << "\n";
    return EXIT_SUCCESS;
  }

  std::cerr << "Environment variable " << argv[1] << " not found\n";
  return EXIT_FAILURE;

}
