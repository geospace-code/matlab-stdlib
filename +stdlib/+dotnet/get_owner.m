%% DOTNET.GET_OWNER get the owner of a filepath

function o = get_owner(file)
arguments
  file (1,1) string
end

% This is not yet possible with .NET on Unix, even with .NET 10.
% It would require Pinvoke or external Mono.Unix

o = "";

ntAccountType = System.Type.GetType('System.Security.Principal.NTAccount');
if isempty(ntAccountType)
  return
end

if isfolder(file)
  fsec = System.IO.Directory.GetAccessControl(file);
elseif isfile(file)
  fsec = System.IO.File.GetAccessControl(file);
else
  o = "";
  return
end

owner = fsec.GetOwner(ntAccountType);

o = string(owner.ToString());

end
