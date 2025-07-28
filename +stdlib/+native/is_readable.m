function y = is_readable(p)

y = false;

if ~stdlib.exists(p), return, end

if ~isMATLABReleaseOlderThan('R2025a')

  props = "Readable";
  if isunix
    props = [props, "GroupRead", "OtherRead"];
  end

  t = getPermissions(filePermissions(p), props);
  y = any(t{1, :});

else

  a = stdlib.native.file_attributes(p);
  y = a.UserRead || a.GroupRead || a.OtherRead;

end

end
