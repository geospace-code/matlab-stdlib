%% FILE_CHECKSUM compute hash of file
%
% read in chunks to avoid excessive RAM use
%
%%% Inputs
% * file: file or to hash
% * hash_method:  'MD5', 'SHA-1', 'SHA-256', etc.
% * backend: backend to use
%%% Outputs
% * hash: string hash
% * b: backend used
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/security/MessageDigest.html#getInstance(java.lang.String)

function [r, b] = file_checksum(file, hash_method, backend)
arguments
  file (1,1) string {mustBeFile}
  hash_method {mustBeTextScalar}
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "shell"]
end


r = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".file_checksum");
  r = f(file, hash_method);

  if ~ismissing(r)
    return
  end
end

end
