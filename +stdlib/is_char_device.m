%% IS_CHAR_DEVICE is path a character device
%
% e.g. NUL, /dev/null
% false if file does not exist
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a character device
% * b: backend used
%
% Windows: Console handles
%   CONIN$, CONOUT$, STDIN, STDOUT, STDERR are not detected. Only NUL is detected.
%   in our C-API-based Ffilesystem library, we use GetFileType() with CreateFile() to
%   detect those handles successfully, but they don't work here.
%
% Ref: https://learn.microsoft.com/en-us/windows/console/console-handles


function [i, b] = is_char_device(file, backend)
arguments
  file string
  backend (1,:) string = ["python", "sys"]
end

i = logical.empty;

for b = backend
  switch b
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.is_char_device(file);
    case 'sys'
      i = stdlib.sys.is_char_device(file);
    otherwise
      error("stdlib:is_char_device:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
