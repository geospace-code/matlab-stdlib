%% FILESYSTEM_TYPE tell type of filesystem
% requires: java
%
% example outputs: ntfs, ext4, apfs, ...
%
% if empty output or error, try specifying the drive root
% like "/" or "C:/"

function t = filesystem_type(p)
arguments
  p (1,1) string = ""
end

t = "";

if strlength(p) && ~stdlib.exists(p), return, end

op = javaPathObject(p);

if stdlib.isoctave()
  t = javaMethod("getFileStore", "java.nio.file.Files", op).type;
else
  t = string(java.nio.file.Files.getFileStore(op).type);
end

end

%!assert(!isempty(filesystem_type(pwd)))
