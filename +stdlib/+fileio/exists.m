function ok = exists(p)
%% exists does path exist
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#exists()

arguments
  p (1,1) string
end

ok = java.io.File(p).exists();

end
