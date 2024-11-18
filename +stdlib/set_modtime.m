function ok = set_modtime(p)
%% SET_MODTIME set modification time of path
arguments
  p (1,1) string
end

utc = convertTo(datetime("now", "TimeZone", "UTC"), "posixtime");

ok = java.io.File(p).setLastModified(int64(utc) * 1000);

end
