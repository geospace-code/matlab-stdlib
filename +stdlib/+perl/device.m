function [r, cmd] = device(file)

cmd = sprintf('''%s'' -e ''($f=shift) && -e $f or exit 1; print +(stat $f)[0]'' ''%s''', stdlib.perl_exe(), file);

[s, r] = system(cmd);
if s == 0
  r = str2double(r);
else
  r = [];
end

r = uint64(r);

end
