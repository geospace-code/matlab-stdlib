function o = get_owner(p)

if ~stdlib.exists(p)
  o = string.empty;
  return
end

if ispc()
  cmd = "pwsh -c (Get-Acl -Path '" + p + "').Owner";
elseif ismac()
  cmd = "stat -f %Su " + p;
else
  cmd = "stat -c %U " + p;
end

[s, o] = system(cmd);
if s == 0
  o = string(strip(o));
else
  o = string.empty;
end

end
