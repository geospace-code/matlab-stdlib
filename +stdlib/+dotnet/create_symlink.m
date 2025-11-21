function ok = create_symlink(target, link)
% DOTNET.CREATE_SYMLINK create symbolic link to target

if ~stdlib.exists(target) || stdlib.strempty(link) || stdlib.exists(link)
  ok = false;
  return
end

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
try
  System.IO.File.CreateSymbolicLink(link, target);
  ok = true;
catch e
  dotnetException(e)
  ok = logical([]);
end

end
