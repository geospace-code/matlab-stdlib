%% IS_CHAR_DEVICE is path a character device
%
% e.g. NUL, /dev/null
% false if file does not exist
%
%% Inputs
% * file: path to check
% * backend: backend to use
%% Outputs
% * ok: true if path is a character device
% * b: backend used
%
% Windows: Console handles
%   CONIN$, CONOUT$, STDIN, STDOUT, STDERR are not detected. Only NUL is detected.
%   in our C-API-based Ffilesystem library, we use GetFileType() with CreateFile() to
%   detect those handles successfully, but they don't work here.
%
% Ref: https://learn.microsoft.com/en-us/windows/console/console-handles


function [ok, b] = is_char_device(file, backend)
arguments
  file string
  backend (1,:) string = ["python", "sys"]
end

[fun, b] = hbackend(backend, "is_char_device");

if isscalar(file)
  ok = fun(file);
else
  ok = arrayfun(fun, file);
end

end
