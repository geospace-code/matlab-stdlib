%% TOUCH create file if not exists, else update modification time

function ok = touch(p, t)
arguments
  p {mustBeTextScalar}
  t (1,1) datetime = datetime("now")
end

if ~stdlib.exists(p)
  fid = fopen(p, "w");
  ok = fid > 0 && fclose(fid) == 0;
end

if ok
  ok = stdlib.set_modtime(p, t);
end

end

%!test
%! f = tempname();
%! assert (touch(f, now()))
%! assert (isfile(f))
%! delete(f)
