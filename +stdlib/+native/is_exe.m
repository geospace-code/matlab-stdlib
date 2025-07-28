function y = is_exe(p)

y = isfile(p);

if ispc()
  y = y && stdlib.native.has_windows_executable_suffix(p);
end

if ~y, return, end


if ~isMATLABReleaseOlderThan('R2025a')

  if isunix
    props = ["UserExecute", "GroupExecute", "OtherExecute"];
  else
    props = "Readable";
  end

  t = getPermissions(filePermissions(p), props);

  y = any(t{1, :});

else

  a = stdlib.native.file_attributes(p);
  y = a.UserExecute || a.GroupExecute || a.OtherExecute;

end

end
