%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(file, time)

utc = posixtime(datetime(time, 'TimeZone', "UTC"));

try
  ok = java.io.File(file).setLastModified(int64(utc) * 1000);
catch e
  javaException(e)
  ok = logical.empty;
end

end
