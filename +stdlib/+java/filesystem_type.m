function t = filesystem_type(p)

if stdlib.exists(p)
  t = string(javaMethod("getFileStore", "java.nio.file.Files", javaPathObject(p)).type);
else
  t = string.empty;
end

end
