%% SYS.FILE_CHECKSUM compute checksum of file
function [hash, cmd] = file_checksum(file, hash_method)

switch lower(hash_method)
  case {"sha-256", "sha256"}
    if ismac()
      cmd = sprintf('shasum --algorithm 256 --binary "%s"', file);
    elseif ispc()
      cmd = sprintf('CertUtil -hashfile "%s" SHA256', file);
    else
      cmd = sprintf('sha256sum --binary "%s"', file);
    end
  case "md5"
    if ismac()
      cmd = sprintf('md5 -r "%s"', file);
    elseif ispc()
      cmd = sprintf('CertUtil -hashfile "%s" MD5', file);
    else
      cmd = sprintf('md5sum "%s"', file);
    end
  otherwise, error('unhandled hash method %s', hash_method)
end

[s, m] = system(cmd);

if s ~= 0
  hash = '';
  return
end

switch lower(hash_method)
  case {"sha-256", "sha256"}
    hash = regexp(m, '^\w{64}','match','once','lineanchors');
  case "md5"
    hash = regexp(m, '^\w{32}','match','once','lineanchors');
end

end
