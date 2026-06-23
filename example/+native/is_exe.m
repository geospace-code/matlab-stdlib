function y = is_exe(file)
arguments
  file string
end

y = false;

if ispc() && ~stdlib.native.has_windows_executable_suffix(file)
  return
end

if isunix
  props = ["UserExecute", "GroupExecute", "OtherExecute"];
else
  props = "Readable";
end

y = getPermissions(filePermissions(file), props);

end
