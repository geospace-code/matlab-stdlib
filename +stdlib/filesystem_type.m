%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: ntfs, ext4, apfs, ...

function t = filesystem_type(p)
arguments
  p (1,1) string
end

t = string(java.nio.file.Files.getFileStore(java.io.File(p).toPath()).type());

end
