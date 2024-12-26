%% SET_MODTIME set modification time of path

function ok = set_modtime(p, t)
arguments
  p (1,1) string
  t (1,1) datetime = datetime("now")
end

try
  utc = convertTo(datetime(t, "TimeZone", "UTC"), "posixtime");
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    if nargin == 2
      utc = t;
    else
      utc = time();
    end
  else
    rethrow(e);
  end
end

if stdlib.isoctave()
  o = javaObject("java.io.File", p);
else
  o = java.io.File(p);
end

ok = o.setLastModified(int64(utc) * 1000);

end

%!test
%! p = tempname();
%! assert(touch(p))
%! assert(set_modtime(p))
%! delete(p)
