%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(p, utc)

if isdatetime(utc)
  utc = convertTo(datetime(utc, 'TimeZone', "UTC"), "posixtime");
end

ok = javaObject("java.io.File", p).setLastModified(int64(utc) * 1000);

end
