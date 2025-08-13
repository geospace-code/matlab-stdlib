%% JAVA.GET_OWNER get owner of file

function n = get_owner(p)

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

if stdlib.exists(p)
  opt = java.nio.file.LinkOption.values();
  n = char(java.nio.file.Files.getOwner(javaPathObject(p), opt));
else
  n = '';
end

try %#ok<TRYNC>
  n = string(n);
end

end
