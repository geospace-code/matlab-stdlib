function t = filesystem_type(p)

if stdlib.exists(p)
  t = char(javaMethod("getFileStore", "java.nio.file.Files", javaPathObject(p)).type);
else
  t = '';
end

end
