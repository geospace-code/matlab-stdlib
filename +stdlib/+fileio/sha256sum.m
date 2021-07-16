function hash = sha256sum(file)
% compute sha256 hash of file
arguments
  file (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);
assert(isfile(file), '%s not found', file)

hash = string.empty;

if ismac
  [stat,hash] = system("shasum --algorithm 256 --binary " + file);
elseif isunix
  [stat,hash] = system("sha256sum --binary " + file);
elseif ispc
  [stat,hash] = system("CertUtil -hashfile " + file + " SHA256");
else
  return
end

if stat ~= 0
  return
end

hash = regexp(hash,'^\w{64}','match','once','lineanchors');

assert(strlength(hash)==64, 'SHA256 hash is 64 characters')

end % function
