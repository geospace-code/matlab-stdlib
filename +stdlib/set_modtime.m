%% SET_MODTIME set modification time of path

function ok = set_modtime(p, t)
arguments
  p {mustBeTextScalar, mustBeFile}
  t (1,1) datetime
end

try
  utc = convertTo(datetime(t, 'TimeZone', "UTC"), "posixtime");
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    utc = t;
  else
    rethrow(e);
  end
end

% Java or Python assume POSIX epoch time (seconds since Jan 1, 1970)
if stdlib.has_java()
  ok = javaObject("java.io.File", p).setLastModified(int64(utc) * 1000);
elseif stdlib.has_python()
  ok = stdlib.python.set_modtime(p, utc);
end

if ~ok
  ok = stdlib.sys.set_modtime(p, t);
end

end

%!test
%! p = tempname();
%! t = now();
%! assert(touch(p, t))
%! assert(set_modtime(p, t))
%! delete(p)
