function hash = sha256sum(file)
%% SHA256SUM compute sha256 hash of file
arguments
  file (1,1) string {mustBeFile}
end

hash = stdlib.file_checksum(file, "SHA-256");

end
