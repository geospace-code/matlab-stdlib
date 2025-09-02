function [y, cmd] = is_admin()

if ispc()
  % https://metacpan.org/pod/Win32#Win32::IsAdminUser()
  c = 'use Win32; print Win32::IsAdminUser() ? 1 : 0';
else
  % check if the user ID is 0 (root)
  c = 'print $< == 0 ? 1 : 0';
end

y = logical.empty;

exe = stdlib.perl_exe();
if stdlib.strempty(exe)
  return
end

cmd = sprintf('"%s" -e "%s"', exe, c);

[s, m] = system(cmd);

y = s == 0 && m == "1";

end
