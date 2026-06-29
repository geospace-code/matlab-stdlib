function v = version()

if stdlib.has_java()
  v = char(javaMethod('getProperty', 'java.lang.System', 'java.version'));
else
  v = missing;
end

end
