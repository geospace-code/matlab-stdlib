function y = samepath(path1, path2)

y = false;

if ~stdlib.exists(path1) || ~stdlib.exists(path2)
  return
end

if ispc()
  y = stdlib.sys.device(path1) == stdlib.sys.device(path2) && ...
      stdlib.sys.inode(path1) == stdlib.sys.inode(path2);
  return
end


if ismac()
  flag = '-f';
else
  flag = '-c';
end

cmd1 = sprintf('stat %s %%d:%%i "%s"', flag, path1);
cmd2 = sprintf('stat %s %%d:%%i "%s"', flag, path2);

cmd = stdlib.append(cmd1, ' && ', cmd2);

[s, m] = system(cmd);
if s ~= 0
  warning("stdlib:sys:samepath:RuntimeError", "stdlib.sys.samepath(%s, %s) failed: %s", path1, path2, m)
  return
end

% m = splitlines(m);
% to allow older Matlab / Octave compatibility
m = strsplit(m, {'\n', '\r'});
assert(length(m) >= 2, "samepath(%s, %s) failed: unexpected output", path1, path2);

y = strcmp(m{1}, m{2});

end
