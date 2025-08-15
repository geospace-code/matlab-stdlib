function i = disk_capacity(file)
arguments
  file (1,1) string
end

i = java.io.File(file).getTotalSpace();
if i < 1
  i = [];
end

i = uint64(i);
end
