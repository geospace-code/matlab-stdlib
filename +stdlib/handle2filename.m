%% HANDLE2FILENAME Convert a file handle to a filename

function name = handle2filename(fileHandle)
arguments
    fileHandle (1,1) {mustBeInteger}
end

if fileHandle >= 0
  name = stdlib.posix(fopen(fileHandle));
else
  name = string.empty;
end

end
