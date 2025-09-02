%% DOTNET.DISK_AVAILABLE find the disk space available to the user

function i = disk_available(file)

i = uint64.empty;
if ~stdlib.exists(file)
  return
end

try
% absolutizing is necessary for Windows especially
  i = System.IO.DriveInfo(System.IO.Path.GetFullPath(file)).AvailableFreeSpace();
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.availablefreespace
catch e
  dotnetException(e)
end

i = uint64(i);

end
