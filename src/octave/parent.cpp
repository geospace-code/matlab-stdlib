#include <octave/oct.h>

#include <string>
#include <filesystem>

#include "pure.cpp"
#include "normalize_fs.cpp"


DEFUN_DLD (parent, args, nargout,
           "get parent directory")
{
  if (args.length() != 1){
    octave_stdout << "Oct: One input required\n";
    return octave_value("");
  }

  auto par = std::filesystem::path(fs_drop_slash(args(0).string_value())).parent_path();

  if (par.empty())
    return ".";

  // need this for <filesystem> or _splitpath_s to make x: x:/
  if (fs_is_windows() && par == par.root_name())
    par += '/';

  return octave_value(par.string());
}
