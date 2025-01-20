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

  std::string out = std::filesystem::path(fs_drop_slash(args(0).string_value())).parent_path().generic_string();

  return octave_value(out);
}
