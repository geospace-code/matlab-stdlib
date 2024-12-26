%% JAVAFILEOBJECT Return a Java File object for a given file path.
function o = javaFileObject(p)

try
    o = java.io.File(p);
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    o = javaObject("java.io.File", p);
  else
    rethrow(e);
  end
end

end
