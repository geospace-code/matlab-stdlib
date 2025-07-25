function i = device(p)


if ispc()
  cmd = "powershell -Command (Get-CimInstance -ClassName Win32_Volume -Filter 'DriveLetter = \"" + p(1) + "\"').DeviceID";
elseif ismac()
  cmd = "stat -f %d " + p;
elseif isunix()
  cmd = "stat -c %d " + p;
end


[s, m] = system(cmd);
if s == 0
  i = str2double(m);
end

end
