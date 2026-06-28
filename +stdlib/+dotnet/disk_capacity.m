%% DOTNET.DISK_CAPACITY find the overall disk capacity visible to user

function i = disk_capacity(file)

% Windows needs exists() not just strempty()
if stdlib.has_dotnet() && stdlib.exists(file)
  % absolutizing is necessary for Windows especially
  i = System.IO.DriveInfo(System.IO.Path.GetFullPath(file)).TotalSize();
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize
  i = uint64(i);
else
  i = missing;
end

end
