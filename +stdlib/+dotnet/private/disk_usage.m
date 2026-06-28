function i = disk_usage(file, v)

% Windows needs exists() not just strempty()
if stdlib.has_dotnet() && stdlib.exists(file)
  % absolutizing is necessary for Windows especially
  di = System.IO.DriveInfo(System.IO.Path.GetFullPath(file));

  switch v
    case 'available', i = di.AvailableFreeSpace();
    case 'capacity', i = di.TotalSize();
    otherwise, error('stdlib:dotnet:disk_usage:valueError', 'unknown disk_usage property %s', v)
  end
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize
  i = uint64(i);
else
  i = missing;
end

end
