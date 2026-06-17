function [ok, cmd] = is_char_device(file)

if ispc()
  % https://learn.microsoft.com/en-us/windows/console/console-handles
  charDevs = ["NUL", "CONIN$", "CONOUT$"];
  ok = ismember(file, charDevs);
  cmd = '';
else
  cmd = sprintf('test -c %s', file);

  [s, ~] = system(cmd);
  ok = s == 0;
end

end
