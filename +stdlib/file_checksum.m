%% FILE_CHECKSUM compute hash of file
% requires: java
%
% read in chunks to avoid excessive RAM use
%
%%% Inputs
% * file: file or to hash
% * method:  "MD5", "SHA-1", "SHA-256", etc.
%%% Outputs
% * hash: string hash
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#getInstance(java.lang.String)

function hash = file_checksum(file, method)
arguments
  file {mustBeFile}
  method {mustBeTextScalar}
end

if any(strcmp(method, {'sha256', 'SHA256'}))
  method = "SHA-256";
end

file_chunk = 10e6;  % arbitrary (bytes) didn't seem to be very sensitive for speed

if stdlib.isoctave()
  inst = javaMethod("getInstance", "java.security.MessageDigest", method);
else
  inst = java.security.MessageDigest.getInstance(method);
end

fid = fopen(file, 'r');
assert(fid > 1, "could not open file %s", file)

while ~feof(fid)
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#update(byte)
  inst.update(fread(fid, file_chunk, '*uint8'));
end
fclose(fid);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#digest()
hash = typecast(inst.digest, 'uint8');

hash = sprintf('%.2x', hash);

end

%!assert(!isempty(file_checksum('file_checksum.m', "sha256")))
