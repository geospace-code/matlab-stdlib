%% TOUCH create file if not exists, else update modification time

function ok = touch(p, t)
arguments
  p (1,1) string
  t (1,1) datetime = datetime("now")
end

ok = false;

if ~stdlib.exists(p)
  fid = fopen(p, "w");
  if fid < 0 || fclose(fid) ~= 0
    return
  end
end

ok = stdlib.set_modtime(p, t);

end

%!test
%! f = tempname();
%! t = time();
%! assert (touch(f, t))
%! assert (isfile(f))
