function n = get_username()

if ispc()
  cmd = "whoami";
else
  cmd = "id -un";
end
[s, n] = system(cmd);

if s == 0
  n = string(strtrim(n));
else
  warning("Failed to get username from system %s: %s", cmd, n);
  n = string.empty;
end

end
