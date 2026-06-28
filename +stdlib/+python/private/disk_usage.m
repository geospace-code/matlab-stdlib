function i = disk_usage(file, v)

i = missing;

if stdlib.has_python()
try
  u = py.shutil.disk_usage(file);
  switch v
    case 'total', i = u.total;
    case 'free', i = u.free;
    otherwise, error('stdlib:python:disk_usage:valueError', 'unknown disk_usage property %s', v)
  end
  i = uint64(i);
catch e
  if e.identifier ~= "MATLAB:undefinedVarOrClass"
    rethrow(e);
  end
end
end

end
