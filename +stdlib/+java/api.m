%% JAVA_API Java API version

function a = api()

a = str2double(java.lang.System.getProperty('java.specification.version'));

end
