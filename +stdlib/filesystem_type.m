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

if stdlib.has_dotnet()
  t = System.IO.DriveInfo(stdlib.absolute(p)).DriveFormat;
elseif stdlib.has_java()
  op = javaPathObject(p);

  t = javaMethod("getFileStore", "java.nio.file.Files", op).type;
end

try  %#ok<*TRYNC>
  t = string(t);
end

end

%!assert(!isempty(filesystem_type(pwd)))
