function [n, cmd] = hostname()

cmd = 'hostname';
[s, r] = system(cmd);
assert(s == 0, 'stdlib:shell:hostname', 'Error executing hostname command %s: %s', cmd, r);

n = deblank(r);

end
