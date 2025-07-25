%% IS_WRITABLE is path writable
%
%%% Inputs
% p: string array of file paths
%% Outputs
% ok: logical array of the same size as p, true if file is writable

function ok = is_writable(p)
arguments
  p string
end

ok(size(p)) = false;

i = stdlib.exists(p);

if ~any(i), return, end

if ~isMATLABReleaseOlderThan('R2025a')

  props = "Writable";
  if isunix
    props = [props, "GroupWrite", "OtherWrite"];
  end

  t = getPermissions(filePermissions(p(i)), props);
  ok(i) = any(t{:,:}, 2);

else
  a = file_attributes_legacy(p);
  ok = a.UserWrite || a.GroupWrite || a.OtherWrite;
end

end
%!assert (is_writable('is_writable.m'))
