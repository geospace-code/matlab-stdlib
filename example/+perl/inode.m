%% PERL.INODE
% several times slower than stdlib.shell.inode

function [i, cmd] = inode(file)

i = missing;

exe = stdlib.perl_exe();
if ismissing(exe)
  return
end

c = stdlib.perl.perl2cmd('($f=shift) && -e $f or exit 1; print +(stat $f)[1]');

cmd = sprintf('"%s" -e %s "%s"', exe, c, file);

[s, r] = system(cmd);
if s == 0
  i = uint64(str2double(r));
end


end
