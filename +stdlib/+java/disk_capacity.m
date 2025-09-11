function i = disk_capacity(file)

try
  i = java.io.File(file).getTotalSpace();
  if i < 1
    i = [];
  end
catch e
  javaException(e)
  i = [];
end

i = uint64(i);

end
