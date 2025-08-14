function y = is_exe(file)
arguments
  file (1,1) string
end

y = false;

if ispc() && ~stdlib.native.has_windows_executable_suffix(file)
  return
end

if ~isfile(file), return, end

a = file_attributes(file);
y = a.UserExecute || a.GroupExecute || a.OtherExecute;

end
