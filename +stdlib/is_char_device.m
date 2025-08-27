%% IS_CHAR_DEVICE is path a character device
%
% e.g. NUL, /dev/null
% false if file does not exist
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
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

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  ok = o.func(file);
else
  ok = arrayfun(o.func, file);
end

b = o.backend;

end
