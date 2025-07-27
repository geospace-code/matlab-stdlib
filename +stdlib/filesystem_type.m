%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...

function t = filesystem_type(p)

if stdlib.has_java()
  t = stdlib.java.filesystem_type(p);
elseif stdlib.has_dotnet()
  t = stdlib.dotnet.filesystem_type(p);
elseif stdlib.python.has_psutil()
  t = stdlib.python.filesystem_type(p);
else
  t = stdlib.sys.filesystem_type(p);
end

end
