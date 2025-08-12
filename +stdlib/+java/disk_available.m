function i = disk_available(file)

i = java.io.File(file).getUsableSpace();

i = uint64(i);
end
