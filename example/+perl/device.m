%% PERL.DEVICE filesystem device index of path

function [i, cmd] = device(file)

i = missing;

exe = stdlib.perl_exe();
if ismissing(exe)
  return
end

c = stdlib.perl.perl2cmd('($f=shift) && -e $f or exit 1; print +(stat $f)[0]');

cmd = sprintf('"%s" -e %s "%s"', exe, c, file);

[s, i] = system(cmd);
if s == 0
  i = uint64(str2double(i));
end

end
