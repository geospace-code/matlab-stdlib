%% DOTNET.DISK_AVAILABLE find the disk space available to the user

function i = disk_available(file)

% Windows needs exists() not just strempty()
if stdlib.has_dotnet() && stdlib.exists(file)
  % absolutizing is necessary for Windows especially
  i = System.IO.DriveInfo(System.IO.Path.GetFullPath(file)).AvailableFreeSpace();
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.availablefreespace
  i = uint64(i);
else
  i = missing;
end

end
