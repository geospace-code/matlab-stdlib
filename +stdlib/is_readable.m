%% IS_READABLE is file readable

function ok = is_readable(p)

if ~stdlib.isoctave() && ~isMATLABReleaseOlderThan('R2025a')
  props = "Readable";
  if isunix
    props = [props, "GroupRead", "OtherRead"];
  end
  t = getPermissions(filePermissions(p), props);
  ok = any(t{:,:}, 2);
else
  a = file_attributes_legacy(p);
  ok = a.UserRead || a.GroupRead || a.OtherRead;
end

%!assert (is_readable('is_readable.m'))
