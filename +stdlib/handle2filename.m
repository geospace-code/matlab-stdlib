%% HANDLE2FILENAME Convert a file handle to a filename
function n = handle2filename(fileHandle)
arguments
  fileHandle (1,1) {mustBeInteger}
end

n = '';

if fileHandle >= 0
  n = fopen(fileHandle);
end

end
