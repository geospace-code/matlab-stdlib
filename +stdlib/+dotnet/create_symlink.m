function ok = create_symlink(target, link)

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
try
  System.IO.File.CreateSymbolicLink(link, target);
  ok = true;
catch e
  warning(e.identifier, "%s", e.message)
  ok = false;
end

end
