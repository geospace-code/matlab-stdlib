%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: ntfs, ext4, apfs, ...

function t = filesystem_type(p)
% arguments
%   p (1,1) string
% end

if stdlib.isoctave()
  op = javaObject("java.io.File", p).toPath();
  m = javaMethod("getFileStore", "java.nio.file.Files", op);
else
  op = java.io.File(p).toPath();
  m = java.nio.file.Files.getFileStore(op);
end

  t = m.type();

  try %#ok<TRYNC>
    t = string(t);
  end

end

%!assert(!isempty(filesystem_type(pwd)))
