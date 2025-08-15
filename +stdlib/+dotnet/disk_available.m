%% DOTNET.DISK_AVAILABLE find the disk space available to the user

function f = disk_available(file)
arguments
  file (1,1) string
end

f = uint64([]);

if ~stdlib.exists(file), return, end

f = uint64(System.IO.DriveInfo(stdlib.absolute(file)).AvailableFreeSpace());
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.availablefreespace
end
