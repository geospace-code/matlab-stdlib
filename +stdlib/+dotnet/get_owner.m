%% DOTNET.GET_OWNER get the owner of a filepath

function o = get_owner(file)

% This is not yet possible with .NET on Unix, even with .NET 10.
% It would require Pinvoke or external Mono.Unix

if ispc() && stdlib.has_dotnet()
  ntAccountType = System.Type.GetType('System.Security.Principal.NTAccount');

  if isfolder(file)
    fsec = System.IO.Directory.GetAccessControl(file);
  elseif isfile(file)
    fsec = System.IO.File.GetAccessControl(file);
  else
    o = missing;
    return
  end

  owner = fsec.GetOwner(ntAccountType);

  o = char(owner.ToString());
else
  o = missing;
end

end
