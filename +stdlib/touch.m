%% TOUCH create file if not exists, else update modification time

function ok = touch(file)

ok = stdlib.exists(file);

if ~ok
  fid = fopen(file, "w");
  ok = fid > 0 && fclose(fid) == 0;
end

if ok
  ok = stdlib.set_modtime(file, datetime("now"));
end

end
