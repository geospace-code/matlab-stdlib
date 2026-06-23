function y = is_readable(file)
arguments
  file (1,1) string
end

props = "Readable";
if isunix
  props = [props, "GroupRead", "OtherRead"];
end

y = getPermissions(filePermissions(file), props);

end
