%% DOTNET.IS_REMOVABLE detect removable drive
%
% This does NOT detect USB flash drives, so we DON'T automatically use it.
%
% Ref: https://learn.microsoft.com/en-us/dotnet/api/system.io.drivetype

function y = is_removable(filepath)

try
  fmt = System.IO.DriveInfo(filepath).DriveType;
  y = any(isequal(fmt, {System.IO.DriveType.Removable, ...
                        System.IO.DriveType.CDRom}));
catch e
  dotnetException(e)
  y = false;
end

end
