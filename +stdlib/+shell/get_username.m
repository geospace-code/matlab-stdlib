function [n, cmd] = get_username()

if ispc()
  cmd = 'whoami';
else
  cmd = 'id -un';
end
[s, n] = system(cmd);

if s == 0
  n = deblank(n);
else
  n = '';
end

end
