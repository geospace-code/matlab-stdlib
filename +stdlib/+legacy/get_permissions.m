function p = get_permissions(file)

p = '';

if stdlib.exists(file)
  p = stdlib.native.perm2char(file_attributes(file));
end

end
