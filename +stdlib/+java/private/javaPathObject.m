function o = javaPathObject(p)
% JAVAPATHOBJECT return a Java nio.file.Path object for a given file path.

ja = javaArray('java.lang.String', 0);
o = javaMethod('get', 'java.nio.file.Paths', p, ja);

% o = java.io.File(p).toPath();
% javaArray way about 20% faster

end
