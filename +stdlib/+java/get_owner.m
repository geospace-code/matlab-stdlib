%% JAVA.GET_OWNER get owner of file
%
%% JAVA.FILESYSTEM_TYPE
%
% if stdlib.exists() was not adequate here, as on some CI systems, say Windows with Matlab
% R2025a, despite the same setup on a laptop working.
% stdlib.exists() was true, the Java function threw java.nio.file.NoSuchFileException.
%
% this try-catch is faster and more robust

function n = get_owner(file)

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

n = "";
if ~strlength(file), return, end

try %#ok<TRYNC>
  opt = java.nio.file.LinkOption.values();
  n = string(java.nio.file.Files.getOwner(javaPathObject(file), opt));
end

end
