%% DOTNET.IS_ADMIN is the user running as root?

function y = is_admin()

% Use .NET System.Security.Principal to check for admin privileges
try
  identity = System.Security.Principal.WindowsIdentity.GetCurrent();
  principal = System.Security.Principal.WindowsPrincipal(identity);
  y = principal.IsInRole(System.Security.Principal.WindowsBuiltInRole.Administrator);
catch e
  dotnetException(e)
  y = logical.empty;
end

end
