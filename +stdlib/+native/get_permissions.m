function p = get_permissions(file)

p = '';

if ~stdlib.exists(file), return, end

v = filePermissions(file);

p = stdlib.native.perm2char(v, file);

end
