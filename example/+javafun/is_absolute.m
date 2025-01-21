function y = is_absolute()
% java is about 5x to 10x slower than intrinsic
  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#isAbsolute()
  y = javaFileObject(p).isAbsolute();
end
