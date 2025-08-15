function y = is_char_device(file)
arguments
  file (1,1) string
end

try
  y = py.pathlib.Path(file).is_char_device();
catch
  y = logical.empty;
end

end
