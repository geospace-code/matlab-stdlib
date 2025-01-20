%% MD5SUM compute MD5 hash of file
% requires: java
function hash = md5sum(file)
arguments
  file (1,1) string
end

hash = stdlib.file_checksum(file, "md5");

end

%!assert(~isempty(md5sum('md5sum.m')))
