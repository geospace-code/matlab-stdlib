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

function hash = file_checksum(file, hash_method, backend)
arguments
  file {mustBeTextScalar}
  hash_method {mustBeTextScalar}
  backend (1,:)  string = ["java", "dotnet", "sys"]
end

fun = hbackend(backend, "file_checksum");

hash = fun(file, hash_method);

end
