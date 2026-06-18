%% TOUCH create file if not exists, else update modification time

function ok = touch(file)
arguments
  file {mustBeTextScalar}
end

fid = fopen(file, 'a');
ok = fid > 0 && fclose(fid) == 0;

if ok
  ok = stdlib.set_modtime(file, datetime('now'));
end

end
