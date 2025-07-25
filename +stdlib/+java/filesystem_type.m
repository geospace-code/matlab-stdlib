function t = filesystem_type(p)

t = string(javaMethod("getFileStore", "java.nio.file.Files", javaPathObject(p)).type);

end
