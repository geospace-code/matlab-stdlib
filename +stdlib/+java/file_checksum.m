%% JAVA.FILE_CHECKSUM compute checksum hash of file
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

inst = java.security.MessageDigest.getInstance(hash_method);
while ~feof(fid)
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#update(byte)
  inst.update(fread(fid, file_chunk, '*uint8'));
end
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#digest()
h = typecast(inst.digest, 'uint8');

fclose(fid);

hash = sprintf('%.2x', h);

end
