%% SET_MODTIME set modification time of path

function ok = set_modtime(p, t)
arguments
  p {mustBeTextScalar, mustBeFile}
  t (1,1) datetime
end

utc = convertTo(datetime(t, 'TimeZone', "UTC"), "posixtime");

% Java or Python assume POSIX epoch time (seconds since Jan 1, 1970)
if stdlib.has_java()
  ok = stdlib.java.set_modtime(p, utc);
elseif stdlib.has_python()
  ok = stdlib.python.set_modtime(p, utc);
else
  ok = stdlib.sys.set_modtime(p, t);
end

end
