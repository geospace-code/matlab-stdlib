function y = is_exe(p)
arguments
  p (1,1) string
end

y = isfile(p);

if ispc()
  y = y && stdlib.native.has_windows_executable_suffix(p);
end

y = y && py.os.access(p, py.os.X_OK);

end
