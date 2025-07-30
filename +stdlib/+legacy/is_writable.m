function y = is_writable(file)

if stdlib.exists(file)
  a = stdlib.native.file_attributes(file);
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
else
  y = false;
end

end
