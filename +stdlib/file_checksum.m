%% FILE_CHECKSUM compute hash of file
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
  file (1,1) string
  method (1,1) string
end

hash = [];

if stdlib.is_url(file), return, end

if strcmp(method, "sha256") || strcmp(method, "SHA256")
  method = "SHA-256";
end

file_chunk = 10e6;  % arbitrary (bytes) didn't seem to be very sensitive for speed

if stdlib.isoctave()
  inst = javaMethod("getInstance", "java.security.MessageDigest", method);
else
  inst = java.security.MessageDigest.getInstance(method);
end

fid = fopen(file, 'r');
if fid < 1, return, end

while ~feof(fid)
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#update(byte)
  inst.update(fread(fid, file_chunk, '*uint8'));
end
fclose(fid);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#digest()
hash = typecast(inst.digest, 'uint8');

hash = sprintf('%.2x', hash);

try %#ok<TRYNC>
  hash = string(hash);
end

end

%!assert(!isempty(file_checksum('file_checksum.m', "sha256")))
