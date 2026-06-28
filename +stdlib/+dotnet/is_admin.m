%% DOTNET.IS_ADMIN is the user running as root?

function y = is_admin()

% Use .NET System.Security.Principal to check for admin privileges
if ispc()
  identity = System.Security.Principal.WindowsIdentity.GetCurrent();
  principal = System.Security.Principal.WindowsPrincipal(identity);
  y = principal.IsInRole(System.Security.Principal.WindowsBuiltInRole.Administrator);
else
  y = missing;
end

end
