function y = is_writable(file)
arguments
  file (1,1) string
end

props = "Writable";
if isunix
  props = [props, "GroupWrite", "OtherWrite"];
end

y = getPermissions(filePermissions(file), props);

end
