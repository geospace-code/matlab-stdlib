%% DOTNET.FILESYSTEM_TYPE type of the partition e.g. NTFS, ext4, ...

function t = filesystem_type(p)

if stdlib.exists(p)
  t = string(System.IO.DriveInfo(stdlib.absolute(p)).DriveFormat);
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.driveformat
else
  t = string.empty;
end

end
