function n = get_username()

if stdlib.has_java()
  n = char(javaMethod('getProperty', 'java.lang.System', 'user.name'));
else
  n = missing;
end

end
