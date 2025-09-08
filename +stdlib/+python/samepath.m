function y = samepath(path1, path2)

y = false;

try
  y = py.os.path.samefile(path1, path2);
catch e
  pythonException(e)
end

end
