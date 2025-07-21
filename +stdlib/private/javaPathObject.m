%% JAVAPATHOBJECT Return a Java nio.file.Path object for a given file path.
function o = javaPathObject(p)

o = javaMethod("get", "java.nio.file.Paths", p, javaArray('java.lang.String', 0));

% o = javaObject("java.io.File", p).toPath();
% javaArray way about 20% faster

end
