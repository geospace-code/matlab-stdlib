function i = inode(m)

i = [];

if ispc()
  cmd = "fsutil file queryfileid " + m;
elseif ismac()
  cmd = "stat -f %i " + m;
else
  cmd = "stat -c %i " + m;
end

[s, m] = system(cmd);
if s == 0
  i = str2double(m);
end

i = uint64(i);

end
