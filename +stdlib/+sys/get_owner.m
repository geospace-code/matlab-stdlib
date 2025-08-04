function o = get_owner(p)

o = string.empty;
if ~stdlib.exists(p), return, end

if ispc()
  cmd = "pwsh -c (Get-Acl -Path '" + p + "').Owner";
elseif ismac()
  cmd = "stat -f %Su " + '"' + p + '"';
else
  cmd = "stat -c %U " + '"' + p + '"';
end

[s, m] = system(cmd);
if s == 0
  o = string(strip(m));
end

end
