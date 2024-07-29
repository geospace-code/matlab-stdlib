function isabs = is_absolute(p)
%% IS_ABSOLUTE
% is path absolute?
%
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#isAbsolute()
arguments
  p (1,1) string
end

isabs = java.io.File(p).toPath().isAbsolute();

end
