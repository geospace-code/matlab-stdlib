#include <string>
#include <string_view>

bool fs_win32_is_symlink(std::string_view);

std::string fs_shortname(std::string_view);

std::string fs_as_posix(std::string_view);
