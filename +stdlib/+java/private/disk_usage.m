function i = disk_usage(file, v)

% JDK 25 started assuming '' is '.', which earlier JDK didn't do.
o = java.io.File(file);
switch v
  case 'available', k = 'getUsableSpace';
  case 'capacity', k = 'getTotalSpace';
  otherwise, error('stdlib:java:disk_usage:valueError', 'unknown disk_usage property %s', v)
end
i = javaMethod(k, o);
if i < 1
  i = missing;
else
  i = uint64(i);
end

end
