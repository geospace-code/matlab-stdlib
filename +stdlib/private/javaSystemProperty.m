function p = javaSystemProperty(k)

if stdlib.isoctave()
  p = javaMethod("getProperty", "java.lang.System", k);
else
  p = string(java.lang.System.getProperty(k));
end

end
