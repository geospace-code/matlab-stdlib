%% SET_MODTIME set modification time of path
% requires: java

function ok = set_modtime(p, t)
arguments
  p {mustBeTextScalar}
  t (1,1) datetime
end

try
  utc = convertTo(datetime(t, TimeZone="UTC"), "posixtime");
catch e
  switch e.identifier
    case "Octave:undefined-function", utc = t;
    otherwise, rethrow(e);
  end
end

ok = javaFileObject(p).setLastModified(int64(utc) * 1000);

end

%!test
%! p = tempname();
%! t = now();
%! assert(touch(p, t))
%! assert(set_modtime(p, t))
%! delete(p)
