function y = samepath(path1, path2)

if ~stdlib.exists(path1) || ~stdlib.exists(path2)
  y = false;
  return
end
  
try
  y = py.os.path.samefile(path1, path2);
catch e
  pythonException(e)
  y = logical.empty;
end

end
