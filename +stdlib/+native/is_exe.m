function y = is_exe(file)
arguments
  file string
end

y = isfile(file);

if ispc()
  y = y & stdlib.native.has_windows_executable_suffix(file);
end

if ~any(y)
  return
end

if isunix
  props = ["UserExecute", "GroupExecute", "OtherExecute"];
else
  props = "Readable";
end

try
  t = getPermissions(filePermissions(file(y)), props);
  y(y) = any(t{:, :}, 2);
catch
  y = logical.empty;
end

end
