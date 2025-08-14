%% DOTNET.CREATE_SYMLINK create symbolic link to target

function ok = create_symlink(target, link)

ok = false;

if ~stdlib.exists(target) || stdlib.strempty(link) || stdlib.exists(link)
  return
end

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
try %#ok<TRYNC>
  System.IO.File.CreateSymbolicLink(link, target);
  ok = true;
end

end
