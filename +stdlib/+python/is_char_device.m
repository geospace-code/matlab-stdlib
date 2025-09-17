function y = is_char_device(file)

try
  y = py.pathlib.Path(file).is_char_device();
catch e
  pythonException(e)
  y = logical([]);
end

end
