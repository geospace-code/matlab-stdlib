function i = disk_capacity(file)

i = missing;

try
  o = javaObject('java.io.File', file);
  i = javaMethod('getTotalSpace', o);
  if i < 1
    i = missing;
  else
    i = uint64(i);
  end
catch e
  javaException(e)
end

end
