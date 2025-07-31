%% JAVA_API Java API version

function a = java_api()

try
  a = javaMethod("getProperty", "java.lang.System", "java.specification.version");
catch
  a = [];
end

if ~isempty(a)
  a = str2double(a);
end

end
