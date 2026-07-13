%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(file, time)

utc = posixtime(datetime(time, 'TimeZone', 'UTC'));
o = java.io.File(file);
ok = o.setLastModified(int64(utc) * 1000);

end
