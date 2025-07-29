function n = get_owner(p)

n = string.empty;
if ~stdlib.exists(p), return, end

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

try
  opt = javaMethod("values", "java.nio.file.LinkOption");

  n = string(javaMethod("getOwner", "java.nio.file.Files", javaPathObject(p), opt));
catch e
  warning(e.identifier, "get_owner(%s) failed: %s", p, e.message)
end

end
