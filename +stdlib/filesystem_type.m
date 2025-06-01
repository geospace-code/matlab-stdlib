%% FILESYSTEM_TYPE tell type of filesystem
% requires: java
%
% example outputs: ntfs, ext4, apfs, ...
%
% if empty output or error, try specifying the drive root
% like "/" or "C:/"

function t = filesystem_type(p)
arguments
  p {mustBeTextScalar} = ''
end

assert(stdlib.exists(p), "Path does not exist: %s", p);

op = javaPathObject(p);

if stdlib.isoctave()
  t = javaMethod("getFileStore", "java.nio.file.Files", op).type;
else
  t = java.nio.file.Files.getFileStore(op).type.string;
end

end

%!assert(!isempty(filesystem_type(pwd)))
