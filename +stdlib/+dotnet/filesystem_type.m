function t = filesystem_type(p)

if ~stdlib.exists(p)
  t = string.empty;
  return
end

t = string(System.IO.DriveInfo(stdlib.absolute(p)).DriveFormat);
% https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.driveformat

end
