%% IS_EXE is file executable
%
% false if not a file

function ok = is_exe(p)
arguments
  p string
end
% need to have string array type for p(:)

p = p(:);

ok(size(p)) = false;

i = isfile(p);

if ispc()
  pe = split(string(getenv("PATHEXT")), pathsep);
  i = i & endsWith(stdlib.suffix(p(i)), pe, 'IgnoreCase', true);
end

if ~any(i), return, end

if ~isMATLABReleaseOlderThan('R2025a')

  if isunix
    props = ["UserExecute", "GroupExecute", "OtherExecute"];
  else
    props = "Readable";
  end

  t(i, :) = getPermissions(filePermissions(p(i)), props);

  ok(i) = any(t{i,:}, 2);

else

  a = file_attributes_legacy(p);
  ok = a.UserExecute || a.GroupExecute || a.OtherExecute;

end

end

%!assert (!is_exe("."))
%!assert (is_exe(program_invocation_name))
