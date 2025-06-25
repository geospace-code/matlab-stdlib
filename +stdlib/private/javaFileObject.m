%% JAVAFILEOBJECT Return a Java File object for a given file path.
function o = javaFileObject(p)

if stdlib.isoctave()
  o = javaObject("java.io.File", p);
else
  o = java.io.File(p);
end

end
