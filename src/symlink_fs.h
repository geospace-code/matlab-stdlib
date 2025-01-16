#include <string>

bool fs_is_symlink(std::string);
bool fs_create_symlink(std::string, std::string);
std::string fs_read_symlink(std::string);
