%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(file, time)

if stdlib.has_java()
  utc = posixtime(datetime(time, 'TimeZone', 'UTC'));
  o = javaObject('java.io.File', file);
  ok = javaMethod('setLastModified', o, int64(utc) * 1000);
else
  ok = missing;
end

end
