%% shell.FILE_CHECKSUM compute checksum of file
function [hash, cmd] = file_checksum(file, hash_method)

switch lower(hash_method)
  case {'sha-256', 'sha256'}
    if ismac()
      cmd = sprintf('shasum --algorithm 256 --binary "%s"', file);
    elseif ispc()
      cmd = sprintf('CertUtil -hashfile "%s" SHA256', file);
    else
      cmd = sprintf('sha256sum --binary "%s"', file);
    end
  case 'md5'
    if ismac()
      cmd = sprintf('md5 -r "%s"', file);
    elseif ispc()
      cmd = sprintf('CertUtil -hashfile "%s" MD5', file);
    else
      cmd = sprintf('md5sum "%s"', file);
    end
  otherwise, error('unhandled hash method %s', hash_method)
end

if ispc() && stdlib.file_size(file) == 0
  hash = missing;
  return
end

[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:file_checksum', 'Error executing file_checksum(%s, %s) command %s: %s', file, hash_method, cmd, m);

switch lower(hash_method)
case {'sha-256', 'sha256'}
  hash = regexp(m, '^\w{64}','match','once','lineanchors');
case 'md5'
  hash = regexp(m, '^\w{32}','match','once','lineanchors');
end

end
