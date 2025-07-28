%% IS_EXE is file executable
%
% false if not a file

function ok = is_exe(p)
arguments
  p string
end

ok(size(p)) = false;

i = isfile(p);

if ispc()
  i = i & has_windows_executable_suffix(p(i));
end

if ~any(i), return, end

if ~isMATLABReleaseOlderThan('R2025a')

  if isunix
    props = ["UserExecute", "GroupExecute", "OtherExecute"];
  else
    props = "Readable";
  end

  t = getPermissions(filePermissions(p(i)), props);

  ok(i) = any(t{:,:}, 2);

else

  a = stdlib.native.file_attributes(p);
  ok = a.UserExecute || a.GroupExecute || a.OtherExecute;

end

end
