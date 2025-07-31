%% IS_CHAR_DEVICE is path a character device
%
% e.g. NUL, /dev/null
% false if file does not exist
%
% Windows: Console handles
%   CONIN$, CONOUT$, STDIN, STDOUT, STDERR are not detected. Only NUL is detected.
%   in our C-API-based Ffilesystem library, we use GetFileType() with CreateFile() to
%   detect those handles successfully, but they don't work here.
%
% Ref: https://learn.microsoft.com/en-us/windows/console/console-handles


function ok = is_char_device(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["python", "sys"]
end

fun = choose_method(method, "is_char_device");

ok = fun(file);

end

