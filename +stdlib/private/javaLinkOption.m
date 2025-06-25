function o = javaLinkOption()

if stdlib.isoctave()
  o = javaMethod("values", "java.nio.file.LinkOption");
else
  o = java.nio.file.LinkOption.values;
end

end
