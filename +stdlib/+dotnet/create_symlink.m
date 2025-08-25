%% DOTNET.CREATE_SYMLINK create symbolic link to target

function ok = create_symlink(target, link)
arguments
  target (1,1) string
  link (1,1) string
end

ok = false;

if ~stdlib.exists(target) || stdlib.strempty(link) || stdlib.exists(link)
  return
end

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
try
  System.IO.File.CreateSymbolicLink(link, target);
  ok = true;
catch e
  dotnetException(e)
end

end
