%% SYS.INODE get file inode

function i = inode(m)

i = 0;

if ispc()
  % https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil-file
  cmd = "fsutil file queryfileid " + m;
elseif ismac()
  cmd = "stat -f %i " + m;
else
  cmd = "stat -c %i " + m;
end

[s, m] = system(cmd);
if s == 0
  if ispc()
    m = strrep(strip(m), "File ID is ", "");
    % https://www.mathworks.com/help/releases/R2025a/matlab/ref/hex2dec.html
    i = sscanf(m, '%lx', 1);
    if i == intmax('uint64')
      L = strlength(m);
      i = [sscanf(m(1:L-1), '%lx', 1), sscanf(m(L:end), '%lx', 1)];
    end
  else
    i = str2double(m);
  end
end

i = uint64(i);

end
