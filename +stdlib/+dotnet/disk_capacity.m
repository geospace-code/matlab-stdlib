function f = disk_capacity(d)

f = uint64(System.IO.DriveInfo(stdlib.absolute(d)).TotalSize());
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize

end
