%% SHA256SUM compute sha256 hash of file


function hash = sha256sum(file)
arguments
  file {mustBeTextScalar, mustBeFile}
end

hash = stdlib.file_checksum(file, 'SHA-256');

end
