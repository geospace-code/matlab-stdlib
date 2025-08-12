%% TOUCH create file if not exists, else update modification time

function ok = touch(file, t)
arguments
  file
  t (1,1) datetime = datetime("now")
end

ok = stdlib.exists(file);

if ~ok
  fid = fopen(file, "w");
  ok = fid > 0 && fclose(fid) == 0;
end

if ok
  ok = stdlib.set_modtime(file, t);
end

end
