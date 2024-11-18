function ok = touch(p)
%% TOUCH create file if not exists, else update modification time
arguments
  p (1,1) string
end

if stdlib.exists(p)
  ok = stdlib.set_modtime(p);
else
  fid = fopen(p, "w");
  if fid < 0
    ok = false;
  else
    ok = fclose(fid) == 0;
  end
end

end
