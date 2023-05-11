function hash = sha256sum(file)

arguments
  file (1,1) string {mustBeFile}
end

if ismac
  [stat, hash] = system("shasum --algorithm 256 --binary " + file);
elseif isunix
  [stat, hash] = system("sha256sum --binary " + file);
elseif ispc
  [stat, hash] = system("CertUtil -hashfile " + file + " SHA256");
else
  error("no sha256sum method for your OS")
end

assert(stat == 0, hash, "failed to compute SHA256 hash of " + file)

hash = regexp(hash,'^\w{64}','match','once','lineanchors');
hash = string(hash);

assert(strlength(hash)==64, 'SHA256 hash is 64 characters')

end
