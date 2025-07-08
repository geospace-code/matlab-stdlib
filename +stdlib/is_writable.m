%% IS_WRITABLE is path writable

function ok = is_writable(p)

if ~stdlib.isoctave() && ~isMATLABReleaseOlderThan('R2025a')
  props = "Writable";
  if isunix
    props = [props, "GroupWrite", "OtherWrite"];
  end
  t = getPermissions(filePermissions(p), props);
  ok = any(t{:,:}, 2);
else
  a = file_attributes_legacy(p);
  ok = a.UserWrite || a.GroupWrite || a.OtherWrite;
end

end
%!assert (is_writable('is_writable.m'))
