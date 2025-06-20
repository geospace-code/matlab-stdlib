#include <octave/oct.h>

#include <string>
#include <filesystem>
#include <system_error>


DEFUN_DLD (relative_to, args, nargout,
           "path relative to base path")
{
  if (args.length() != 2){
    octave_stdout << "Oct: Two inputs required\n";
    return octave_value("");
  }

  std::error_code ec;

  std::string out = std::filesystem::relative(args(1).string_value(),
                                              args(0).string_value(),
                                              ec).generic_string();

  if(ec)
    octave_stdout << ec.message() << "\n";

  return octave_value(out);
}
