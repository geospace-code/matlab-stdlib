function i = disk_capacity(d)

i = java.io.File(d).getTotalSpace();
if i < 1
  i = [];
end

i = uint64(i);
end
