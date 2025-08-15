function i = disk_available(file)
arguments
  file (1,1) string
end

i = java.io.File(file).getUsableSpace();
if i < 1
  i = [];
end

i = uint64(i);
end
