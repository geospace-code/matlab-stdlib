%% JAVA_API Java API version

function a = api()

if stdlib.has_java()
  a = javaMethod('getProperty', 'java.lang.System', 'java.specification.version');
  a = str2double(a);
else
  a = missing;
end

end
