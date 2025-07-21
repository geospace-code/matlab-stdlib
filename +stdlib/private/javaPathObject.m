%% JAVAPATHOBJECT Return a Java nio.file.Path object for a given file path.
function o = javaPathObject(p)

if stdlib.isoctave()
  o = javaObject("java.io.File", p).toPath();
else
  o = java.nio.file.Paths.get(p, javaArray('java.lang.String', 0));
  % o = javaObject("java.io.File", p).toPath();  % above way about 20% faster
end

end
