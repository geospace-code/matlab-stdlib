function o = get_owner(file)
% DOTNET.GET_OWNER get the owner of a filepath
%
% This is not yet possible with .NET on Unix, even with .NET 10.
% It would require Pinvoke or external Mono.Unix

o = '';

try
  ntAccountType = System.Type.GetType('System.Security.Principal.NTAccount');

  if isfolder(file)
    fsec = System.IO.Directory.GetAccessControl(file);
  elseif isfile(file)
    fsec = System.IO.File.GetAccessControl(file);
  else
    return
  end

  owner = fsec.GetOwner(ntAccountType);

  o = char(owner.ToString());
catch e
  dotnetException(e)
end

end
