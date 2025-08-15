function y = is_readable(file)
arguments
  file (1,1) string
end

if stdlib.exists(file)
  a = file_attributes(file);
  y = a.UserRead || a.GroupRead || a.OtherRead;
else
  y = false;
end

end
