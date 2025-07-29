function y = is_readable(file)

if stdlib.exists(file)
  a = stdlib.native.file_attributes(file);
  y = a.UserRead || a.GroupRead || a.OtherRead;
else
  y = false;
end

end
