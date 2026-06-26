%% HANDLE2FILENAME Convert an integer file handle to a filename
%
%%% Inputs
% * fileHandle: Integer file handle as returned by fopen
%%% Outputs
% * n: Filename. Empty if file handle is invalid.

function n = handle2filename(fileHandle)
arguments
  fileHandle (1,1)
end

n = missing;

if fileHandle >= 0
  n = fopen(fileHandle);
end

end
