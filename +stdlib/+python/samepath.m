function y = samepath(path1, path2)

try
   y = py.os.path.samefile(path1, path2);
catch e
  if strcmp(e.identifier, 'MATLAB:Python:PyException') && contains(e.message, 'FileNotFoundError')
    y = false;
  else
    pythonException(e)
    y = logical([]);
  end
end

end
