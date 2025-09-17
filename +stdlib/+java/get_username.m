function n = get_username()

try
  n = char(javaMethod('getProperty', 'java.lang.System', 'user.name'));
catch e
  javaException(e)
  n = '';
end

end
