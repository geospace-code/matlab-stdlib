function y = is_readable(file)

y = false;

if ~stdlib.exists(file), return, end

props = "Readable";
if isunix
  props = [props, "GroupRead", "OtherRead"];
end

t = getPermissions(filePermissions(file), props);
y = any(t{1, :});

end
