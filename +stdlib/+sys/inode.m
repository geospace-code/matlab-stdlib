%% SYS.INODE get file inode

function [i, cmd] = inode(p)

i = [];

if ispc()
  % https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil-file
  cmd = sprintf('fsutil file queryfileid "%s"', p);
elseif ismac()
  cmd = sprintf('stat -f %%i "%s"', p);
else
  cmd = sprintf('stat -c %%i "%s"', p);
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
