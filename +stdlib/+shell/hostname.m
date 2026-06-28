function [n, cmd] = hostname()

cmd = 'hostname';
[s, r] = system(cmd);

if s == 0
  n = deblank(r);
else
  n = missing;
end

end
