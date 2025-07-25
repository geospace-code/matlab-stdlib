function t = filesystem_type(p)

t = javaMethod("getFileStore", "java.nio.file.Files", javaPathObject(p)).type;

end
