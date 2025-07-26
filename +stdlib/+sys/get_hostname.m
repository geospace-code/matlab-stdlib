function n = get_hostname()

cmd = "hostname";
[s, n] = system(cmd);

if s == 0
  n = string(strtrim(n));
else
  warning("Failed to get hostname from system %s: %s", cmd, n);
  n = string.empty;
end

end
