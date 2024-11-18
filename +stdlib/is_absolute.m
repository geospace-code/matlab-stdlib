%% IS_ABSOLUTE is path absolute?
%
% Ref: https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#isAbsolute()

function isabs = is_absolute(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  % java is about 5x to 10x slower than intrinsic
  isabs = java.io.File(p).toPath().isAbsolute();
else
  L = strlength(p);
  if ispc
    isabs = L >= 2 && isletter(extractBetween(p, 1, 1)) && extractBetween(p, 2, 2) == ":";
  else
    isabs = L >= 1 && startsWith(p, "/");
  end
end

end
