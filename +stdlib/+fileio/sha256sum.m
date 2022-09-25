function hash = sha256sum(file)
% compute sha256 hash of file
arguments
  file (1,1) string {mustBeFile}
end

file = stdlib.fileio.expanduser(file);

if ismac
  [stat,hash] = system("shasum --algorithm 256 --binary " + file);
elseif isunix
  [stat,hash] = system("sha256sum --binary " + file);
elseif ispc
  [stat,hash] = system("CertUtil -hashfile " + file + " SHA256");
else
  error("no md5sum method for your OS")
end

assert(stat == 0, hash)

hash = regexp(hash,'^\w{64}','match','once','lineanchors');
hash = string(hash);

assert(strlength(hash)==64, 'SHA256 hash is 64 characters')

end % function
