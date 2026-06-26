function y = samepath(path1, path2)

y = false;

if ispc()
  y = stdlib.shell.device(path1) == stdlib.shell.device(path2) & ...
      stdlib.shell.inode(path1) == stdlib.shell.inode(path2);
  if isempty(y)
    y = false;
  end

  return
end


if ismac()
  flag = '-f';
else
  flag = '-c';
end

cmd1 = sprintf('stat %s %%d:%%i "%s"', flag, path1);
cmd2 = sprintf('stat %s %%d:%%i "%s"', flag, path2);

cmd = stdlib.append(cmd1, stdlib.cmdsep(), cmd2);

[s, m] = system(cmd);
if s == 0

  % m = splitlines(m);
  % to allow older Matlab / Octave compatibility
  m = strsplit(m, {'\n', '\r'});
  assert(length(m) >= 2, "samepath(%s, %s) failed: unexpected output", path1, path2);

  y = strcmp(m{1}, m{2});
end

end
