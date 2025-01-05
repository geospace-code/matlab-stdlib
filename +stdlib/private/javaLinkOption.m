function o = javaLinkOption()

try
  o = java.nio.file.LinkOption.values;
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    o = javaMethod("values", "java.nio.file.LinkOption");
  else
    rethrow(e);
  end
end
