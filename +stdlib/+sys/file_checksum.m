%% SYS.FILE_CHECKSUM compute checksum of file
function hash = file_checksum(file, hash_method)

switch lower(hash_method)
  case {"sha-256", "sha256"}
    if ismac()
      cmd = "shasum --algorithm 256 --binary " + file;
    elseif ispc()
      cmd = "CertUtil -hashfile " + file + " SHA256";
    else
      cmd = "sha256sum --binary " + file;
    end
  case "md5"
    if ismac()
      cmd = "md5 -r " + file;
    elseif ispc()
      cmd = "CertUtil -hashfile " + file + " MD5";
    else
      cmd = "md5sum " + file;
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
