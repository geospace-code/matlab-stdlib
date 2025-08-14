%% DOTNET.GET_OWNER get the owner of a filepath

function o = get_owner(p)

% This is not yet possible with .NET on Unix, even with .NET 10.
% It would require Pinvoke or external Mono.Unix

o = "";

ntAccountType = System.Type.GetType('System.Security.Principal.NTAccount');
if isempty(ntAccountType)
  return
end

if isfolder(p)
  fsec = System.IO.Directory.GetAccessControl(p);
elseif isfile(p)
  fsec = System.IO.File.GetAccessControl(p);
else
  o = "";
  return
end

owner = fsec.GetOwner(ntAccountType);

o = string(owner.ToString());

end
