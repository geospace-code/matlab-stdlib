function hash = md5sum(file)
% compute MD5 hash of file
arguments
  file (1,1) string
end

file = stdlib.fileio.expanduser(file);

assert(isfile(file), '%s not found', file)

hash = string.empty;

if verLessThan('matlab', '9.7')
  return
end

if ismac
  [stat,hash] = system("md5 -r " + file);
elseif isunix
  [stat,hash] = system("md5sum " + file);
elseif ispc
  [stat,hash] = system("CertUtil -hashfile " + file + " MD5");
else
  return
end

if stat ~= 0
  return
end

hash = regexp(hash,'^\w{32}','match','once','lineanchors');

assert(strlength(hash)==32, 'md5 hash is 32 characters')

end % function
