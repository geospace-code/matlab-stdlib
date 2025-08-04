function i = device(p)

i = 0;

if ispc()
  c0 = 'pwsh -c "(Get-CimInstance -ClassName Win32_Volume -Filter \"DriveLetter = ''';
  c1 = stdlib.root_name(stdlib.absolute(p));
  c2 = '''\").SerialNumber"';
  cmd = strcat(c0, c1, c2);
elseif ismac()
  cmd = sprintf('stat -f %%d "%s"', p);
else
  cmd = sprintf('stat -c %%d "%s"', p);
end


[s, m] = system(cmd);
if s == 0
  i = str2double(m);
end

i = uint64(i);

end
