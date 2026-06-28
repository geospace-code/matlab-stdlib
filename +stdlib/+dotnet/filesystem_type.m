%% DOTNET.FILESYSTEM_TYPE type of the partition e.g. NTFS, ext4, ...

function t = filesystem_type(file)

% Windows needs exists() not just strempty()
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.driveformat

if stdlib.has_dotnet()
  t = char(System.IO.DriveInfo(System.IO.Path.GetFullPath(file)).DriveFormat);
else
  t = missing;
end

end
