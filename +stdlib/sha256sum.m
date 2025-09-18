%% SHA256SUM compute sha256 hash of file


function hash = sha256sum(file)
hash = stdlib.file_checksum(file, 'SHA-256');
end
