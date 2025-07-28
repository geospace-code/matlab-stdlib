%% DOTNET.DISK_AVAILABLE find the disk space available to the user

function f = disk_available(p)

f = uint64(0);

if ~stdlib.exists(p), return, end

f = uint64(System.IO.DriveInfo(stdlib.absolute(p)).AvailableFreeSpace());
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.availablefreespace
end
