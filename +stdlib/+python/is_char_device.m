function y = is_char_device(p)

try
  y = py.pathlib.Path(p).is_char_device();
catch e
  y = logical.empty;
end

end