%% IS_REMOVABLE - Check if a file path is on a removable drive
% Not necessarily perfectly reliable at detection, but works for most cases.

function y  = is_removable(filepath)

y = false;

if ispc()
  drive = stdlib.root_name(filepath);
  cmd1 = strcat('wmic logicaldisk where "DeviceID=''', drive, '''" get DriveType');
else
  cmd1 = "df " + filepath + " | tail -n 1 | awk '{print $1}'";
end
[s1, m1] = system(cmd1);
if s1 ~= 0
  return
end


if ispc()

  y = any(ismember(strtrim(extractAfter(m1, "DriveType")), ["2", "5"]));
  % https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-logicaldisk

elseif ismac()

  cmd2 = ['diskutil info ', m1];
  [s2, m2] = system(cmd2);
  y = s2 == 0 && contains(m2, "Removable Media:" + whitespacePattern + "Removable");

else

  dev = strtrim(extractAfter(m1, '/dev/'));
  f1 = strcat('/sys/class/block/', dev, '/removable');
  if isfile(f1)
    y = strtrim(fileread(f1)) == "1";
  end

end

end
