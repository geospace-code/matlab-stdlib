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
if nargin < 2
  backend = {'python', 'sys'};
else
  backend = cellstr(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.is_char_device(file);
      end
    case 'sys'
      i = stdlib.sys.is_char_device(file);
    otherwise
      error('stdlib:is_char_device:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end

%!assert (~stdlib.is_char_device('.'))
