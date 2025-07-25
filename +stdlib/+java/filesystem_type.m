function t = filesystem_type(p)

if ~stdlib.exists(p)
  t = string.empty;
  return
end

t = string(javaMethod("getFileStore", "java.nio.file.Files", javaPathObject(p)).type);

end
