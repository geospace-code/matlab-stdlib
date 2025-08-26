function i = disk_capacity(file)

i = java.io.File(file).getTotalSpace();
if i < 1
  i = [];
end

i = uint64(i);
end
