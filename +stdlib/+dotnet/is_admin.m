%% DOTNET.IS_ADMIN is the user running as root?

function y = is_admin()

% com.sun.security.auth.module.NTSystem().getGroupIDs();
% Administrator group SID (S-1-5-32-544) is not an appropriate check .getGroupIDs because it
% only tells if a user is *allowed* to run as admin, not if they are currently running as admin.

% Use .NET System.Security.Principal to check for admin privileges
identity = System.Security.Principal.WindowsIdentity.GetCurrent();
principal = System.Security.Principal.WindowsPrincipal(identity);
y = principal.IsInRole(System.Security.Principal.WindowsBuiltInRole.Administrator);

end
