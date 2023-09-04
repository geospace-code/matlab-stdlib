function hash = file_checksum(file, method)
%% file_checksum compute checksum of file
% read in chunks to avoid excessive RAM use
%
% method:  "MD5", "SHA-1", "SHA-256", etc.
%
% Reference: https://docs.oracle.com/javase/8/docs/api/java/security/MessageDigest.html
arguments
    file (1,1) string {mustBeFile}
    method (1,1) string {mustBeNonzeroLengthText}
end

if any(method == ["sha256", "SHA256"])
  method = "SHA-256";
end

file_chunk = 10e6;  % arbitrary (bytes) didn't seem to be very sensitive for speed

inst = java.security.MessageDigest.getInstance(method);

fid = fopen(file, 'r');
assert(fid > 0, "could not open " + file)

while ~feof(fid)
  inst.update(fread(fid, file_chunk, '*uint8'))
end
fclose(fid);

hash = typecast(inst.digest, 'uint8');

hash = string(sprintf('%.2x', hash));

end
