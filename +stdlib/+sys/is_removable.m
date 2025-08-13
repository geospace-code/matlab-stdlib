%% SYS.IS_REMOVABLE

function y = is_removable(filepath)

y = false;

if ispc()
  r = stdlib.root_name(filepath);
  if ~strlength(r), return, end
  r = extractBefore(r, 2);

  psFile = fullfile(fileparts(mfilename('fullpath')), "isRemovableDrive.ps1");
  mustBeFile(psFile)

  psCmd = sprintf(". '%s'; IsRemovableDrive -DriveLetter '%s'", psFile, r);

  cmd1 = sprintf('powershell -ExecutionPolicy Bypass -Command "& {%s}"', psCmd);
else
  cmd1 = sprintf('df "%s" | tail -n 1 | awk ''{print $1}''', filepath);
end
[s1, m1] = system(cmd1);
if s1 ~= 0
  warning('stdlib:is_removable:OSError', '%s', m1)
  return
end


if ispc()

  y = contains(m1, "True");

elseif ismac()

  cmd2 = sprintf('diskutil info "%s"', m1);
  [s2, m2] = system(cmd2);
  y = s2 == 0 && contains(m2, "Removable Media:" + whitespacePattern + "Removable");

else

  dev = strip(extractAfter(m1, '/dev/'));
  f1 = sprintf('/sys/class/block/%s/removable', dev);
  if isfile(f1)
    y = strip(fileread(f1)) == "1";
  end

end

end

% We use Powershell .ps1 function because:
%
% drive = stdlib.root_name(filepath);
% WMIC is not available on all systems e.g. GA windows-2025 runner image
%   WMIC doesn't detect USB flash drives -- it sees them as Fixed drives
% cmd1 = sprintf('wmic logicaldisk where "DeviceID=''%s''" get DriveType', drive);
%
% (Get-Volume -DriveLetter H).DriveType also detects USB thumb drives as Fixed like HDD
%
% Get-WmiObject also sees USB as type 3 fixed disk
% cmd1 = sprintf('pwsh -c "Get-WmiObject Win32_LogicalDisk -Filter ''DeviceID=''%s'''' | Select-Object -ExpandProperty DriveType"', drive);


  % WMIC: y = any(ismember(strip(extractAfter(m1, "DriveType")), ["2", "5"]));
  % https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-logicaldisk
