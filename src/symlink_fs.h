#include <string>
#include <string_view>

bool fs_is_symlink(std::string_view);
bool fs_create_symlink(std::string_view, std::string_view);
std::string fs_read_symlink(std::string_view);
