function i = disk_available(file)

i = java.io.File(file).getUsableSpace();
if i < 1
  i = [];
end

i = uint64(i);
end
