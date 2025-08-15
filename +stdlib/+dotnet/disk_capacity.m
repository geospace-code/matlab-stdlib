%% DOTNET.DISK_CAPACITY find the overall disk capacity visible to user

function f = disk_capacity(file)
arguments
  file (1,1) string
end

f = uint64([]);

if ~stdlib.exists(file), return, end

f = uint64(System.IO.DriveInfo(stdlib.absolute(file)).TotalSize());
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize

end
