function i = disk_capacity(file)
% DOTNET.DISK_CAPACITY find the overall disk capacity visible to user

i = uint64([]);
% Windows needs exists() not just strempty()
if ~stdlib.exists(file)
  return
end

try
% absolutizing is necessary for Windows especially
  i = System.IO.DriveInfo(System.IO.Path.GetFullPath(file)).TotalSize();
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize
catch e
  dotnetException(e)
end

i = uint64(i);

end
