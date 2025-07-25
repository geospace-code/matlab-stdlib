%% FILE_CHECKSUM compute hash of file
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

fid = fopen(file, 'r');
assert(fid > 1, "could not open file %s", file)

if stdlib.has_dotnet()

  inst = System.Security.Cryptography.HashAlgorithm.Create(method);
  while ~feof(fid)
    % https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.hashalgorithm.computehash
    inst.ComputeHash(fread(fid, file_chunk, '*uint8'));
  end
  h = uint8(inst.Hash);

elseif stdlib.has_java()

  inst = javaMethod("getInstance", "java.security.MessageDigest", method);
  while ~feof(fid)
    % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#update(byte)
    inst.update(fread(fid, file_chunk, '*uint8'));
  end
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#digest()
  h = typecast(inst.digest, 'uint8');

else
  error('no supported hash method found, please install .NET or Java')
end

fclose(fid);

hash = sprintf('%.2x', h);

end

%!assert(!isempty(file_checksum('file_checksum.m', "sha256")))
