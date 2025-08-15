function ok = set_modtime(file, dt)
arguments
  file (1,1) string
  dt (1,1) datetime
end

ok = false;
if ~isfile(file), return, end

utc = convertTo(datetime(dt, 'TimeZone', "UTC"), "posixtime");

try
  s = py.os.stat(file);
  py.os.utime(file, py.tuple([s.st_atime, utc]));
  ok = true;
catch e
  warning(e.identifier, "set_modtime(%s, %s) failed: %s", file, utc, e.message);
  ok = false;
end

end
