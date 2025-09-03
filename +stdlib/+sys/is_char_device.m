function [ok, cmd] = is_char_device(file)
arguments
  file (1,1) string
end

cmd = '';

if ispc()
  % https://learn.microsoft.com/en-us/windows/console/console-handles
  charDevs = ["NUL", "CONIN$", "CONOUT$"];
  ok = contains(file, charDevs);
else
  cmd = sprintf('test -c %s', file);

  [s, ~] = system(cmd);
  ok = s == 0;
end

end
