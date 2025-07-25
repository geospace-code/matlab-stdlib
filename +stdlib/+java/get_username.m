function n = get_username()

try
  n = string(javaMethod("getProperty", "java.lang.System", "user.name"));
catch e
  warning(e.identifier, "Failed to get username from Java: %s", e.message);
  n = string.empty;
end

end
