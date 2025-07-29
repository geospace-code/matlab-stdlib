function y = is_writable(p)

y = false;

if ~stdlib.exists(p), return, end

props = "Writable";
if isunix
  props = [props, "GroupWrite", "OtherWrite"];
end

t = getPermissions(filePermissions(p), props);
y = any(t{1, :});

end
