%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(file, t)

utc = convertTo(datetime(t, 'TimeZone', "UTC"), "posixtime");

ok = javaObject("java.io.File", file).setLastModified(int64(utc) * 1000);

end
