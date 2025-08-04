function p = get_permissions(file)

p = '';

if stdlib.exists(file)
  p = stdlib.native.perm2char(filePermissions(file));
end

end
