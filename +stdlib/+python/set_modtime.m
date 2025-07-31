function ok = set_modtime(p, dt)

ok = false;
if ~isfile(p), return, end

utc = convertTo(datetime(dt, 'TimeZone', "UTC"), "posixtime");

try
  s = py.os.stat(p);
  py.os.utime(p, py.tuple([s.st_atime, utc]));
  ok = true;
catch e
  warning(e.identifier, "set_modtime(%s, %s) failed: %s", p, utc, e.message);
  ok = false;
end

end
