%% PERL.DEVICE filesystem device index of path

function [r, cmd] = device(file)

c = '($f=shift) && -e $f or exit 1; print +(stat $f)[0]';
if ispc()
  k = sprintf('"%s"', c);
else
  k = sprintf('''%s''', c);
end

r = uint64.empty;

exe = stdlib.perl_exe();
if stdlib.strempty(exe)
  return
end

cmd = sprintf('"%s" -e %s "%s"', exe, k, file);

[s, r] = system(cmd);
if s == 0
  r = str2double(r);
else
  r = [];
end

r = uint64(r);

end
