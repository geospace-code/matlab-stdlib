function y = is_writable(p)

y = false;

if ~stdlib.exists(p), return, end

if ~isMATLABReleaseOlderThan('R2025a')

  props = "Writable";
  if isunix
    props = [props, "GroupWrite", "OtherWrite"];
  end

  t = getPermissions(filePermissions(p), props);
  y = t.Writable;

else
  a = stdlib.native.file_attributes(p);
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
end

end