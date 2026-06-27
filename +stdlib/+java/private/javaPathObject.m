%% JAVAPATHOBJECT Return a Java nio.file.Path object for a given file path.
function o = javaPathObject(p)

o = java.nio.file.Paths.get(p, javaArray('java.lang.String', 0));

% o = java.io.File(p).toPath();
% javaArray way about 20% faster

end
