function y = is_readable(file)
arguments
  file string
end

y = stdlib.exists(file);
if ~any(y)
  return
end

props = "Readable";
if isunix
  props = [props, "GroupRead", "OtherRead"];
end

t = getPermissions(filePermissions(file(y)), props);
y(y) = any(t{:,:}, 2);

end
