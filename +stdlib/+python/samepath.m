function y = samepath(path1, path2)

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
