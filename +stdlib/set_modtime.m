function ok = set_modtime(p)
arguments
  p (1,1) string
end

utc = convertTo(datetime("now", "TimeZone", "UTC"), "posixtime");

ok = java.io.File(p).setLastModified(int64(utc) * 1000);

end