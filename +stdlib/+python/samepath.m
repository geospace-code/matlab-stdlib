function y = samepath(path1, path2)

try
  y = py.os.path.samefile(path1, path2);
catch e
  pythonException(e)
  y = false;
end

end
