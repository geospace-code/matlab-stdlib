%% FILE_CHECKSUM compute hash of file
%
% read in chunks to avoid excessive RAM use
%
%%% Inputs
% * file: file or to hash
% * hash_method:  'MD5', 'SHA-1', 'SHA-256', etc.
% * backend: backend to use
%%% Outputs
% * i: string hash
% * b: backend used
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#getInstance(java.lang.String)

function [i, b] = file_checksum(file, hash_method, backend)
arguments
  file {mustBeTextScalar,mustBeFile}
  hash_method {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename, file, hash_method);

end
