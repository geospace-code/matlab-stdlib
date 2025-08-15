function p = get_permissions(file)
arguments
  file string
end

p = '';

if stdlib.exists(file)
  p = stdlib.native.perm2char(filePermissions(file));
end

end
