%% JAVA_API Java API version

function a = java_api()

try
  a = javaMethod('getProperty', 'java.lang.System', 'java.specification.version');
  a = str2double(a);
catch
  a = [];
end

end
