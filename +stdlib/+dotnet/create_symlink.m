%% DOTNET.CREATE_SYMLINK create symbolic link to target
% .NET >= 6

function ok = create_symlink(target, link)

if stdlib.exists(link)
  ok = false;
  return
end

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
System.IO.File.CreateSymbolicLink(link, target);
ok = true;

end
