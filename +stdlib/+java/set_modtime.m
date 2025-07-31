%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(p, t)

utc = convertTo(datetime(t, 'TimeZone', "UTC"), "posixtime");

ok = javaObject("java.io.File", p).setLastModified(int64(utc) * 1000);

end
