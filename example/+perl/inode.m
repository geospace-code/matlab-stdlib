%% PERL.INODE
% several times slower than stdlib.sys.inode

function [r, cmd] = inode(file)

r = uint64.empty;

exe = stdlib.perl_exe();
if stdlib.strempty(exe)
  return
end

c = stdlib.perl.perl2cmd('($f=shift) && -e $f or exit 1; print +(stat $f)[1]');

cmd = sprintf('"%s" -e %s "%s"', exe, c, file);

[s, r] = system(cmd);
if s == 0
  r = str2double(r);
else
  r = [];
end

r = uint64(r);

end
