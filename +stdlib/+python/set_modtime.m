function ok = set_modtime(file, dt)
arguments
  file (1,1) string
  dt (1,1) datetime
end

if ~isfile(file)
  ok = false;
  return
end

utc = convertTo(datetime(dt, 'TimeZone', "UTC"), "posixtime");

try
  s = py.os.stat(file);
  py.os.utime(file, py.tuple([s.st_atime, utc]));
  ok = true;
catch e
  ok = logical.empty;
end

end
