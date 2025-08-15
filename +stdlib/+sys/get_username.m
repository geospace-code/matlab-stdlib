function [n, cmd] = get_username()

if ispc()
  cmd = 'whoami';
else
  cmd = 'id -un';
end
[s, n] = system(cmd);

if s == 0
  n = strip(n);
else
  n = '';
end

end
