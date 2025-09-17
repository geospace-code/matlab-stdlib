function i = disk_available(file)

try
  o = javaObject('java.io.File', file);
  i = javaMethod('getUsableSpace', o);
  if i < 1
    i = [];
  end
catch e
  javaException(e)
  i = [];
end

i = uint64(i);

end
