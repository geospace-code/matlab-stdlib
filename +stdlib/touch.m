%% TOUCH create file if not exists, else update modification time

function ok = touch(file)

fid = fopen(file, 'a');
ok = fid > 0 && fclose(fid) == 0;

if ok
  ok = stdlib.set_modtime(file, datetime('now'));
end

end

%!test
%! addpath([pwd() '/+java/private'])
%! f = tempname();
%! assert(stdlib.touch(f))
%! assert(stdlib.remove(f))