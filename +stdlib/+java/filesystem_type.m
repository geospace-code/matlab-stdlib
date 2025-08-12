function t = filesystem_type(file)

if stdlib.exists(file)
  t = char(java.nio.file.Files.getFileStore(javaPathObject(file)).type);
else
  t = '';
end

end
