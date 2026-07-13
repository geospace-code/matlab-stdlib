%% shell.INODE get file inode

function [i, cmd] = inode(file)

if ispc()
  % https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil-file
  cmd = sprintf('fsutil file queryfileid "%s"', file);
elseif ismac()
  cmd = sprintf('stat -f %%i "%s"', file);
else
  cmd = sprintf('stat -c %%i "%s"', file);
end

[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:inode', 'Error executing inode command %s: %s', cmd, m);

if ispc()
  m = strrep(m, 'File ID is ', '');
  % https://www.mathworks.com/help/matlab/ref/hex2dec.html
end
i = sscanf(m, '%lx', 1);
if i == intmax('uint64')
  i = string(m);  % like Python interface
else
  i = uint64(i);
end

end
