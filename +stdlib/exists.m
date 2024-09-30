function ok = exists(p, use_java)
%% exists does path exist
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#exists()

arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
% Java takes 2x to 10x as long as intrinsic way worst case
% the intrinsic way above is at least not slower

  ok = java.io.File(p).exists();
else
  ok = isfile(p) || isfolder(p);
end


end
