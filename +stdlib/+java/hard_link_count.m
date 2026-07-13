function i = hard_link_count(file)

if ~ispc() 
  opt = javaMethod('values', 'java.nio.file.LinkOption');
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), ...
        'unix:nlink', opt);
  % i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", java.nio.file.LinkOption.values());
else
  i = missing;
end

end
