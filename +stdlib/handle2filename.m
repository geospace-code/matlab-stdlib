%% HANDLE2FILENAME Convert a file handle to a filename

function n = handle2filename(fileHandle)
% arguments
%   fileHandle (1,1) {mustBeInteger}
% end

mustBeInteger(fileHandle)

n = "";

if fileHandle >= 0
  n = stdlib.posix(fopen(fileHandle));
end

try %#ok<TRYNC>
  n = string(n);
end

end

%!assert(handle2filename(0), "stdin")
