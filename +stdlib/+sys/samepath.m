function y = samepath(path1, path2)

assert(~ispc(), "Unix-like only")

y = false;

if ~stdlib.exists(path1) || ~stdlib.exists(path2)
  return
end

if ismac()
  flag = '-f';
else
  flag = '-c';
end

cmd1 = "stat " + flag + " %d:%i " + '"' + path1 + '"';
cmd2 = "stat " + flag + " %d:%i " + '"' + path2 + '"';

cmd = cmd1 + " && " + cmd2;

[s, m] = system(cmd);
if s ~= 0
  warning("stdlib:sys:samepath:RuntimeError", "stdlib.sys.samepath(%s, %s) failed: %s", path1, path2, m)
  return
end

m = splitlines(m);
assert(length(m) >= 2, "samepath(%s, %s) failed: unexpected output", path1, path2);

y = strcmp(m{1}, m{2});

end
