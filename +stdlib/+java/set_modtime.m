%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(file, t)
arguments
  file (1,1) string
  t (1,1) datetime
end

utc = convertTo(datetime(t, 'TimeZone', "UTC"), "posixtime");

try
  ok = java.io.File(file).setLastModified(int64(utc) * 1000);
catch e
  javaException(e)
  ok = logical.empty;
end

end
