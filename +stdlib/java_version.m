%% JAVA_VERSION get version of Java Virtual Machine
% this gives a long string with more detail
% version("-java")

% these give the Matlab version, not the JVM version.
% java.lang.Runtime.version()
% java.lang.Runtime.getRuntime().version

function v = java_version()

if stdlib.isoctave()
  v = javaMethod("getProperty", "java.lang.System", "java.version");
else
  v = string(java.lang.System.getProperty("java.version"));
end

end

%!assert(!isempty(java_version()))
