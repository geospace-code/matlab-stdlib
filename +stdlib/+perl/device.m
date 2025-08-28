%% PERL.DEVICE filesystem device index of path

function [r, cmd] = device(file)

c = '($f=shift) && -e $f or exit 1; print +(stat $f)[0]';
if ispc()
  k = sprintf('"%s"', c);
else
  k = sprintf('''%s''', c);
end

cmd = sprintf('"%s" -e %s "%s"', stdlib.perl_exe(), k, file);

[s, r] = system(cmd);
if s == 0
  r = str2double(r);
else
  r = [];
end

r = uint64(r);

end
