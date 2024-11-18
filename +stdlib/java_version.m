%% JAVA_VERSION get version of Java Virtual Machine

function v = java_version()

  v = string(java.lang.System.getProperty("java.version"));

% this gives a long string with more detail
% version("-java")

% these give the Matlab version, not the JVM version.
% java.lang.Runtime.version()
% java.lang.Runtime.getRuntime().version
end
