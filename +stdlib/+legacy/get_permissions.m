function p = get_permissions(file)
arguments
  file (1,1) string
end

p = '';

if stdlib.exists(file)
  p = stdlib.native.perm2char(file_attributes(file));
end

end
