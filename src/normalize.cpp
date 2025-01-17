#include <string>
#include <string_view>
#include <algorithm> // std::unique

#include <filesystem>

#include "ffilesystem.h"


std::string fs_drop_slash(std::string_view in)
{
  // drop all trailing "/" and duplicated internal "/"
  if (fs_is_url(in))
    return {};

  std::filesystem::path p(in);

  std::string s = p.generic_string();

  if (!fs_is_windows() || (s.length() != 3 || p != p.root_path())){
    while(s.length() > 1 && s.back() == '/')
      s.pop_back();
  }

  s.erase(std::unique(s.begin(), s.end(), [](char a, char b){ return a == '/' && b == '/'; }), s.end());

  return s;
}
