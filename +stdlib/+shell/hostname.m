function [n, cmd] = hostname()

cmd = 'hostname';
[s, n] = system(cmd);

if s == 0
  n = deblank(n);
else
  n = '';
end

end
