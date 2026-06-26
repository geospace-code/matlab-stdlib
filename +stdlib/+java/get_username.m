function n = get_username()

try
  n = char(javaMethod('getProperty', 'java.lang.System', 'user.name'));
catch e
  n = javaException(e);
end

end
