#if defined(_WIN32)
# include "win32_fs.h"
#else
# include "unistd.h" // for symlink(), readlink()
#endif

#include <string>
#include <string_view>

#if __has_include(<filesystem>)
# include <filesystem>
# include <system_error>
#endif

#include <sys/types.h>
#include <sys/stat.h>

#include "limits_fs.h"
#include "symlink_fs.h"



bool fs_create_symlink(std::string_view target, std::string_view link)
{
  // confusing program errors if target is "" -- we'd never make such a symlink in real use.
  if(target.empty())
    return false;

  // macOS needs empty check to avoid SIGABRT
  if(link.empty())
    return false;

#if defined(__MINGW32__) || (defined(_WIN32) && !defined(__cpp_lib_filesystem))

  const DWORD attr = GetFileAttributesA(target.data());
// https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfileattributesa
// https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants

  if (attr == INVALID_FILE_ATTRIBUTES)
    return false;

  DWORD p = SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE;
  if(attr & FILE_ATTRIBUTE_DIRECTORY)
    p |= SYMBOLIC_LINK_FLAG_DIRECTORY;

  return CreateSymbolicLinkA(link.data(), target.data(), p);
#elif defined(__cpp_lib_filesystem)
  std::error_code ec;
  std::filesystem::path t(target);

  bool isdir = std::filesystem::is_directory(t, ec);
  if (ec)
    return false;

  isdir
    ? std::filesystem::create_directory_symlink(t, link, ec)
    : std::filesystem::create_symlink(t, link, ec);

  return !ec;
#else
  // https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/symlink.2.html
  // https://linux.die.net/man/3/symlink
  return symlink(target.data(), link.data()) == 0;
#endif
}


bool fs_is_symlink(std::string_view path)
{

#if defined(__MINGW32__) || (defined(_WIN32) && !defined(__cpp_lib_filesystem))
  return fs_win32_is_symlink(path);
#elif defined(__cpp_lib_filesystem)
// std::filesystem::symlink_status doesn't detect symlinks on MinGW
  std::error_code ec;
  const auto s = std::filesystem::symlink_status(path, ec);
  return !ec && std::filesystem::is_symlink(s);
#else
  struct stat s;
  return lstat(path.data(), &s) == 0 && S_ISLNK(s.st_mode);
#endif
}


std::string fs_read_symlink(std::string_view path)
{

  if(!fs_is_symlink(path))
    return {};

  std::error_code ec;

#if defined(__MINGW32__) || (defined(_WIN32) && !defined(__cpp_lib_filesystem))
  return fs_win32_final_path(path);
#elif defined(__cpp_lib_filesystem)
  if(auto p = std::filesystem::read_symlink(path, ec); !ec)
    return p.generic_string();
#else
  // https://www.man7.org/linux/man-pages/man2/readlink.2.html
  std::string r(fs_get_max_path(), '\0');

  const ssize_t Lr = readlink(path.data(), r.data(), r.size());
  if (Lr > 0){
    // readlink() does not null-terminate the result
    r.resize(Lr);
    return r;
  }
#endif

  return {};
}
