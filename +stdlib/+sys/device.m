function i = device(p)

i = 0;

if ispc()
  c0 = 'pwsh -c "(Get-CimInstance -ClassName Win32_Volume -Filter \"DriveLetter = ''';
  c1 = stdlib.root_name(stdlib.absolute(p));
  c2 = '''\").SerialNumber"';
  cmd = strcat(c0, c1, c2);
elseif ismac()
  cmd = "stat -f %d " + p;
else
  cmd = "stat -c %d " + p;
end


[s, m] = system(cmd);
if s == 0
  i = str2double(m);
end

i = uint64(i);

end
