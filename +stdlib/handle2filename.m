%% HANDLE2FILENAME Convert a file handle to a filename
% requires: java

function n = handle2filename(fileHandle)
arguments
  fileHandle (1,1) {mustBeInteger}
end

n = '';

if fileHandle >= 0
  n = stdlib.posix(fopen(fileHandle));
end

end

%!assert(handle2filename(0), "stdin")
