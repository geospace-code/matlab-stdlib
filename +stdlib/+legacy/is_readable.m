function y = is_readable(file)

y = false;

a = stdlib.legacy.file_attributes(file);

if ~isempty(a)
  y = a.UserRead || a.GroupRead || a.OtherRead;
end

end
