%% SHA256SUM compute sha256 hash of file

function hash = sha256sum(file)
% arguments
%   file (1,1) string {mustBeFile}
% end

hash = stdlib.file_checksum(file, "SHA-256");

end

%!assert(~isempty(sha256sum('sha256sum.m')))
