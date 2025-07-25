%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...

function t = filesystem_type(p)


t = string.empty;

if stdlib.has_dotnet()
  t = stdlib.dotnet.filesystem_type(p);
elseif stdlib.has_java()
  t = stdlib.java.filesystem_type(p);
elseif stdlib.has_python()
  t = stdlib.python.filesystem_type(p);
end

if strempty(p)
  t = stdlib.sys.filesystem_type(p);
end

end
