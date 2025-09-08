%% DOTNET.FILE_CHECKSUM compute checksum has of file

% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#getInstance(java.lang.String)

function hash = file_checksum(file, hash_method)
arguments
  file (1,1) string
  hash_method (1,1) string
end

if ismember(hash_method, ["sha256", "SHA256"])
  hash_method = "SHA-256";
end

file_chunk = 10e6;  % arbitrary (bytes) didn't seem to be very sensitive for speed

fid = fopen(file, 'r');
assert(fid > 1, "could not open file %s", file)

try
  inst = System.Security.Cryptography.HashAlgorithm.Create(hash_method);
  while ~feof(fid)
    % https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.hashalgorithm.computehash
    inst.ComputeHash(fread(fid, file_chunk, '*uint8'));
  end

  hash = sprintf('%.2x', uint8(inst.Hash));
catch e
  dotnetException(e)
  hash = '';
end

fclose(fid);


end
