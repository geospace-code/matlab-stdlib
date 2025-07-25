%% IS_READABLE is file readable
%
%%% Inputs
% p: string array of file paths
%% Outputs
% ok: logical array of the same size as p, true if file is readable

function ok = is_readable(p)
arguments
  p string
end

ok(size(p)) = false;

i = stdlib.exists(p);

if ~any(i), return, end

if ~isMATLABReleaseOlderThan('R2025a')

  props = "Readable";
  if isunix
    props = [props, "GroupRead", "OtherRead"];
  end

  t = getPermissions(filePermissions(p(i)), props);
  ok(i) = any(t{:,:}, 2);

else

  a = file_attributes_legacy(p);
  ok = a.UserRead || a.GroupRead || a.OtherRead;

end

end
