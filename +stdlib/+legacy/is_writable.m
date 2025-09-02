function y = is_writable(file)
arguments
  file (1,1) string
end

if stdlib.exists(file)
  a = stdlib.legacy.file_attributes(file);
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
else
  y = false;
end

end
