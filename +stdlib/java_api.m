%% JAVA_API Java API version

function a = java_api()

try
  a = java.lang.System.getProperty('java.specification.version');
  a = str2double(a);
catch
  a = [];
end

end
