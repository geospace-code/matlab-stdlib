function y = is_char_device(file)

if stdlib.has_python()
  y = py.pathlib.Path(file).is_char_device();
else
  y = missing;
end

end
