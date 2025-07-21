%% FILESYSTEM_TYPE tell type of filesystem
% optional: java
%
% example outputs: NTFS, ext4, apfs, ...

function t = filesystem_type(p)
arguments
  p {mustBeTextScalar}
end

t = "";
if ~stdlib.exists(p), return, end

if NET.isNETSupported()
  t = string(System.IO.DriveInfo(stdlib.absolute(p)).DriveFormat);
else
  op = javaPathObject(p);

  if stdlib.isoctave()
    t = javaMethod("getFileStore", "java.nio.file.Files", op).type;
  else
    t = java.nio.file.Files.getFileStore(op).type.string;
  end
end

%!assert(!isempty(filesystem_type(pwd)))
