function y = samepath(path1, path2)
arguments
  path1 (1,1) string
  path2 (1,1) string
end

try
  y = py.os.path.samefile(path1, path2);
catch e
  if contains(e.message, "FileNotFoundError")
    y = false;
  else
    rethrow(e);
  end
end

end
