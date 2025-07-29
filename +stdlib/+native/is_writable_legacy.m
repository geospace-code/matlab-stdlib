function y = is_writable_legacy(file)

if stdlib.exists(file)
  a = stdlib.native.file_attributes(file);
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
else
  y = false;
end

end
