function ok = set_permissions(file, readable, writable, executable)

p = filePermissions(file);

if readable ~= 0
  setPermissions(p, "Readable", readable > 0);
end
if writable ~= 0
  setPermissions(p, "Writable", writable > 0);
end
if executable ~= 0
  setPermissions(p, "Executable", executable > 0);
end

ok = true;

end
