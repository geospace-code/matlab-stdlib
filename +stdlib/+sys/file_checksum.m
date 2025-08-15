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

assert(s == 0, "failed to compute SHA256 hash of %s: %s", file, m)

switch lower(hash_method)
  case {"sha-256", "sha256"}
    hash = regexp(m, '^\w{64}','match','once','lineanchors');
    assert(strlength(hash)==64, 'SHA256 hash is 64 characters')
  case "md5"
    hash = regexp(m, '^\w{32}','match','once','lineanchors');
    assert(strlength(hash)==32, 'MD5 hash is 32 characters')
end

end
