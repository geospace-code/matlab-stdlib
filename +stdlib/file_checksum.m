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
if nargin < 3
  backend = {'java', 'dotnet', 'sys'};
else
  backend = cellstr(backend);
end

r = '';

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      r = stdlib.java.file_checksum(file, hash_method);
    case 'dotnet'
      r = stdlib.dotnet.file_checksum(file, hash_method);
    case 'sys'
      r = stdlib.sys.file_checksum(file, hash_method);
    otherwise
      error('stdlib:file_checksum:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(r)
    return
  end
end

end

%!test
%! f = tempname();
%! assert(stdlib.touch(f))
%! hs = stdlib.file_checksum(f, 'sha256', 'sys');
%! assert(length(hs) == 64)
%! if stdlib.has_java()
%! hj = stdlib.file_checksum(f, 'sha256', 'java');
%! assert(strcmp(hs, hj))
%! end
