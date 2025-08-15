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
arguments
  file (1,1) string
end

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

n = "";
if ~strlength(file), return, end

file = stdlib.absolute(file);
% Java 1.8 benefits from absolute.
% We only saw this issue with R2025a on windows-2025 GA runner image.

try %#ok<TRYNC>
  opt = java.nio.file.LinkOption.values();
  n = string(java.nio.file.Files.getOwner(javaPathObject(file), opt));
end

end
