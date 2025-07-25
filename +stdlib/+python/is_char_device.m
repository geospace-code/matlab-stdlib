function y = is_char_device(p)

try
  y = py.pathlib.Path(p).is_char_device();
catch e
  warning(e.identifier, "Python is_char_device failed: %s", e.message);
  y = false;
end
