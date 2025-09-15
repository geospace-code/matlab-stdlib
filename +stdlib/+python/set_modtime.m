function ok = set_modtime(file, time)

utc = convertTo(datetime(time, 'TimeZone', "UTC"), "posixtime");

try
  s = py.os.stat(file);
  py.os.utime(file, py.tuple([s.st_atime, utc]));
  ok = true;
catch e
  if e.identifier == "MATLAB:Python:PyException" && contains(e.message, "FileNotFoundError")
    ok = false;
  else
    ok = logical.empty;
  end
end

end
