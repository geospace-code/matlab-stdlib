function i = hard_link_count(file)

if ~ispc() && stdlib.has_java()
  opt = javaMethod('values', 'java.nio.file.LinkOption');
  p = javaAbsolutePath(file);
  i = javaMethod('getAttribute', 'java.nio.file.Files', p, 'unix:nlink', opt);
  % i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", java.nio.file.LinkOption.values());
else
  i = missing;
end

end
