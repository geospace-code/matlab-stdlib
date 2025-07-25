function ok = set_modtime(p, utc)

ok = false;
if ~isfile(p), return, end

if isdatetime(utc)
  utc = convertTo(datetime(utc, 'TimeZone', "UTC"), "posixtime");
end

try
  s = py.os.stat(p);
  py.os.utime(p, py.tuple([s.st_atime, utc]));
  ok = true;
catch e
  warning(e.identifier, "set_modtime(%s, %s) failed: %s", p, utc, e.message);
  ok = false;
end

end
