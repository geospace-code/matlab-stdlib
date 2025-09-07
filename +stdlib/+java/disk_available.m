function i = disk_available(file)

try
  i = java.io.File(file).getUsableSpace();
  if i < 1
    i = [];
  end
catch e
  javaException(e)
  i = [];
end

i = uint64(i);

end
