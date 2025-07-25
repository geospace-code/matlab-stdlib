function n = get_username()

if ispc()
  cmd = "whoami";
else
  cmd = "id -un";  % POSIX compliant command to get username
end
[s, n] = system(cmd);

if s == 0
  n = strtrim(n);  % Remove any trailing newline or spaces
else
  warning("Failed to get username from system command: %s", n);
  n = string.empty;
end

end
