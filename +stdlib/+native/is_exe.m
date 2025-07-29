function y = is_exe(file)

y = isfile(file);

if ispc()
  y = y && stdlib.native.has_windows_executable_suffix(file);
end

if ~y, return, end

if isunix
  props = ["UserExecute", "GroupExecute", "OtherExecute"];
else
  props = "Readable";
end

t = getPermissions(filePermissions(file), props);

y = any(t{1, :});

end
