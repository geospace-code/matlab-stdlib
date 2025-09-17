%% JAVA.SET_MODTIME set the modification time of a filepath

function ok = set_modtime(file, time)

try
  utc = posixtime(datetime(time, 'TimeZone', 'UTC'));
catch e
  if ~strcmp(e.identifier, 'Octave:undefined-function')
    rethrow(e)
  end
  utc = time;
end

try
  o = javaObject('java.io.File', file);
  ok = javaMethod('setLastModified', o, int64(utc) * 1000);
catch e
  javaException(e)
  ok = logical([]);
end

end
