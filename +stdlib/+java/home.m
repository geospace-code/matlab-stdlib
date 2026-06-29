function h = home()

if stdlib.has_java()
  h = char(javaMethod('getProperty', 'java.lang.System', 'java.home'));
else
  h = missing;
end

end
