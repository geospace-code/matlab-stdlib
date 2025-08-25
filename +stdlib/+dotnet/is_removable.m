%% DOTNET.IS_REMOVABLE detect removable drive
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
