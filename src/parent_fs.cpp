#include <string>
#include <string_view>

#include <filesystem>

#include "ffilesystem.h"

std::string fs_parent(std::string_view in)
{
  std::string out;
  if(in.empty())
    out = ".";
  else
    out = std::filesystem::path(fs_drop_slash(in)).parent_path().generic_string();

  // handle "/" and other no parent cases
  if (out.empty()){
    if (!in.empty() && in.front() == '/')
      out = "/";
    else
      out = ".";
  }

  // make x: x:/
  if (fs_is_windows() && out.length() == 2 && !fs_root_name(out).empty())
    out.push_back('/');

  return out;
}
