function ok = set_modtime(file, time)


if stdlib.has_python()
  utc = posixtime(datetime(time, 'TimeZone', 'UTC'));
  s = py.os.stat(file);
  py.os.utime(file, py.tuple([s.st_atime, utc]));
  ok = true;
else
  ok = missing;
end

end
