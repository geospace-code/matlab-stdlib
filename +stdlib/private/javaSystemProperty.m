function p = javaSystemProperty(k)

try
  p = string(java.lang.System.getProperty(k));
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    p = javaMethod("getProperty", "java.lang.System", k);
  else
    rethrow(e);
  end
end
