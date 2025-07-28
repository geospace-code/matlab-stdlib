function y = samepath(path1, path2)

y = false;

if stdlib.strempty(path1) || stdlib.strempty(path2)
  return
end

if ispc()
  c1 = stdlib.canonical(path1, true);
  c2 = stdlib.canonical(path2, true);
  y = strlength(c1) > 0 && strcmp(c1, c2);
  return
end

if ismac()
  flag = '-f';
else
  flag = '-c';
end

cmd = "stat " + flag + " %d:%i " + path1 + " && stat " + flag + " %d:%i " + path2;

[s, m] = system(cmd);
if s ~= 0, return, end

m = splitlines(m);
assert(length(m) >= 2, "samepath(%s, %s) failed: unexpected output", path1, path2);

y = strcmp(m{1}, m{2});

end
