function y = samepath(path1, path2)

try
 if py.os.path.exists(path1) && py.os.path.exists(path2)
    y = py.os.path.samefile(path1, path2);
 else
    y = false;
 end
catch e
  pythonException(e)
  y = logical.empty;
end

end
