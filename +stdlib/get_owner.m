%% GET_OWNER owner of file or directory

function n = get_owner(p)
arguments
  p (1,1) string
end

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

op = javaFileObject(p).toPath();
opt = javaLinkOption();

if stdlib.isoctave()
  n = javaMethod("getOwner", "java.nio.file.Files", op, opt).toString();
else
  n = string(java.nio.file.Files.getOwner(op, opt));
end

end

%!assert(!isempty(get_owner(pwd)))
