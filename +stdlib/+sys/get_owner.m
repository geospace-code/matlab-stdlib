function o = get_owner(p)

if ispc()
  cmd = "pwsh -c (Get-Acl -Path '" + p + "').Owner";
elseif ismac()
  cmd = "stat -f %Su " + p;
else
  cmd = "stat -c %U " + p;
end

[s, o] = system(cmd);
if s == 0
  o = strip(o);
else
  o = string.empty;
end

end
