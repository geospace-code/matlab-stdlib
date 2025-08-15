function [n, cmd] = get_hostname()

cmd = 'hostname';
[s, n] = system(cmd);

if s == 0
  n = strip(n);
else
  n = '';
end

end
