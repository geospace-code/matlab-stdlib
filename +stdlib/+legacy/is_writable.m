function y = is_writable(file)

y = false;

a = stdlib.legacy.file_attributes(file);

if ~isempty(a)
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
end

end
