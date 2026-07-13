function [n, cmd] = get_username()

if ispc()
  cmd = 'whoami';
else
  cmd = 'id -un';
end

[s, n] = system(cmd);
assert(s==0, "stdlib:shell:get_username", "Failed to get username using %s: %s ", cmd, n);

n = deblank(n);

end
