function hash = sha256sum(file)
%% sha256sum(file)
% compute sha256 hash of file
arguments
  file (1,1) string {mustBeFile}
end

hash = stdlib.fileio.file_checksum(file, "SHA-256");

end
