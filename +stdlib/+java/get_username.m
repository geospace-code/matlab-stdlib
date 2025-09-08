function n = get_username()

try
  n = char(java.lang.System.getProperty('user.name'));
catch e
  javaException(e)
  n = '';
end

end
