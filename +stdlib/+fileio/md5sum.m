function hash = md5sum(file)
% compute MD5 hash of file
arguments
  file (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);
assert(isfile(file), '%s not found', file)

if ismac
  [stat,hash] = system("md5 -r " + file);
elseif isunix
  [stat,hash] = system("md5sum " + file);
elseif ispc
  [stat,hash] = system("CertUtil -hashfile " + file + " MD5");
else
  error("no sha256sum method for your OS")
end

assert(stat == 0, hash)

hash = regexp(hash,'^\w{32}','match','once','lineanchors');
hash = string(hash);

assert(strlength(hash)==32, 'md5 hash is 32 characters')

end % function
