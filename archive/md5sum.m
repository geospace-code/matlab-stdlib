function hash = md5sum(file)
%% md5sum(file)
% DEPRECATED: use file_checksum(file, "md5") instead
% compute MD5 hash of file
arguments
  file (1,1) string {mustBeFile}
end

if ismac
  [stat, hash] = system("md5 -r " + file);
elseif isunix
  [stat, hash] = system("md5sum " + file);
elseif ispc
  [stat, hash] = system("CertUtil -hashfile " + file + " MD5");
else
  error("no method for your OS")
end

assert(stat == 0, hash, "failed to compute md5sum of " + file)

hash = regexp(hash,'^\w{32}','match','once','lineanchors');
hash = string(hash);

assert(strlength(hash)==32, 'md5 hash is 32 characters')

end
