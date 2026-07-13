%% JAVA.FILESYSTEM_TYPE

function t = filesystem_type(file)

% Java 1.8 benefits from absolute path, especially on Windows
%
% if stdlib.exists() was not adequate here, as on some CI systems, despite the same setup on a laptop working.
% stdlib.exists() was true, the Java function threw java.nio.file.NoSuchFileException.

p = javaAbsolutePath(file);
s = java.nio.file.Files.getFileStore(p);
t = char(s.type);

end
