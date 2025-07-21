%% IS_ADMIN is the process run as root / admin
% optional: mex

function y = is_admin()


if stdlib.isoctave()
  y = getuid() == 0;
elseif ispc() && stdlib.has_dotnet()
  % com.sun.security.auth.module.NTSystem().getGroupIDs();
  % Administrator group SID (S-1-5-32-544) is not an appropriate check .getGroupIDs because it
  % only tells if a user is *allowed* to run as admin, not if they are currently running as admin.

  % Use .NET System.Security.Principal to check for admin privileges
  identity = System.Security.Principal.WindowsIdentity.GetCurrent();
  principal = System.Security.Principal.WindowsPrincipal(identity);
  y = principal.IsInRole(System.Security.Principal.WindowsBuiltInRole.Administrator);
elseif isunix()
  if stdlib.has_java()
    y = com.sun.security.auth.module.UnixSystem().getUid() == 0;
  else
    [s, r] = system('id -u');
    y = s == 0 && strip(r) == "0";
  end
else
  error("stdlib:is_admin:UnsupportedPlatform", "is_admin() is not supported on this platform")
end

end

%!assert (islogical(is_admin()))
