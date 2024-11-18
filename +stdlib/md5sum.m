function hash = md5sum(file)
%% MD5SUM compute MD5 hash of file
arguments
  file (1,1) string {mustBeFile}
end

hash = stdlib.file_checksum(file, "md5");

end
