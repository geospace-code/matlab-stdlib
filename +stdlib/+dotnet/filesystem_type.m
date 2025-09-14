%% DOTNET.FILESYSTEM_TYPE type of the partition e.g. NTFS, ext4, ...

function t = filesystem_type(file)


t = '';
% Windows needs exists() not just strempty()
if ~stdlib.exists(file)
  return
end

% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.driveformat

try
  t = char(System.IO.DriveInfo(System.IO.Path.GetFullPath(file)).DriveFormat);
catch e
  dotnetException(e)
end

end
