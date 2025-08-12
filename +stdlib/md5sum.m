%% MD5SUM compute MD5 hash of file

function hash = md5sum(file)
hash = stdlib.file_checksum(file, "md5");
end
