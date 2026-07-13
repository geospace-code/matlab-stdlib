function y = is_char_device(file)

y = py.pathlib.Path(file).is_char_device();

end
