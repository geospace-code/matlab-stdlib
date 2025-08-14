function y = is_writable(file)
arguments
  file string
end

y = stdlib.exists(file);
if ~any(y)
  return
end

props = "Writable";
if isunix
  props = [props, "GroupWrite", "OtherWrite"];
end

try
  t = getPermissions(filePermissions(file(y)), props);
  y(y) = any(t{:,:}, 2);
catch
  y = logical.empty;
end

end
