%% DOTNET.GET_OWNER get the owner of a filepath

function o = get_owner(p)

if ~stdlib.exists(p)
  o = string.empty;
  return
end

ntAccountType = System.Type.GetType('System.Security.Principal.NTAccount');
if isempty(ntAccountType)
  error('NTAccount type not found. Ensure you are running on a Windows system with .NET support.');
end

if isfolder(p)
  fsec = System.IO.Directory.GetAccessControl(p);
else
  fsec = System.IO.File.GetAccessControl(p);
end

owner = fsec.GetOwner(ntAccountType);

o = string(owner.Value);

end
