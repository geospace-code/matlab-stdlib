%% DOTNET.FILESYSTEM_TYPE type of the partition e.g. NTFS, ext4, ...

function t = filesystem_type(file)
arguments
  file (1,1) string
end

if stdlib.exists(file)
  t = char(System.IO.DriveInfo(stdlib.absolute(file)).DriveFormat);
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.driveformat
else
  t = '';
end

end
