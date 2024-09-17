function v = java_version()
% get version of Java Virtual Machine
  v = string(java.lang.System.getProperty("java.version"));

% these give the Matlab version, not the JVM version.
% java.lang.Runtime.version()
% java.lang.Runtime.getRuntime().version
end
