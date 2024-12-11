%% HANDLE2FILENAME Convert a file handle to a filename

function n = handle2filename(fileHandle)
arguments
  fileHandle (1,1) {mustBeInteger}
end

if fileHandle >= 0
  n = stdlib.posix(string(fopen(fileHandle)));
else
  n = string.empty;
end

end
