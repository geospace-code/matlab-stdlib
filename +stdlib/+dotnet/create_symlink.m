%% DOTNET.CREATE_SYMLINK create symbolic link to target

function ok = create_symlink(target, link)

if stdlib.exists(link)
  ok = false;
  return
end

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
if stdlib.has_dotnet() && stdlib.dotnet.api() >= 6
  System.IO.File.CreateSymbolicLink(link, target);
  ok = true;
else
  ok = missing;
end

end
