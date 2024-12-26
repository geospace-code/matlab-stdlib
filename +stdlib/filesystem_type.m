%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: ntfs, ext4, apfs, ...

function t = filesystem_type(p)
arguments
  p (1,1) string
end

op = javaFileObject(p).toPath();

if stdlib.isoctave()
  t = javaMethod("getFileStore", "java.nio.file.Files", op).type;
else
  t = string(java.nio.file.Files.getFileStore(op).type);
end

end

%!assert(!isempty(filesystem_type(pwd)))
