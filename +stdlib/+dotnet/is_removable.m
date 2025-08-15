%% DOTNET.IS_REMOVABLE detect removable drive
%
% Ref: https://learn.microsoft.com/en-us/dotnet/api/system.io.drivetype

function y = is_removable(filepath)
arguments
  filepath (1,1) string
end

if stdlib.exists(filepath)
  fmt = System.IO.DriveInfo(stdlib.absolute(filepath)).DriveType;
  y = any(isequal(fmt, {System.IO.DriveType.Removable, ...
                        System.IO.DriveType.CDRom}));
else
  y = false;
end

end
