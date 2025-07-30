function y = is_exe(file)

y = isfile(file);

if ispc()
  y = y && stdlib.native.has_windows_executable_suffix(file);
end

if ~y, return, end

a = file_attributes(file);
y = a.UserExecute || a.GroupExecute || a.OtherExecute;

end
