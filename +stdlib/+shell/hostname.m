function [n, cmd] = hostname()

n = missing;

cmd = 'hostname';
[s, r] = system(cmd);

if s == 0
  n = deblank(r);
end

end
