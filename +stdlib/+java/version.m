%% JAVA.VERSION get version of Java Virtual Machine
%
% this gives a long string with more detail
% version('-java')

% these give the Matlab version, not the JVM version.
% java.lang.Runtime.version()
% java.lang.Runtime.getRuntime().version

function v = version()

if stdlib.has_java()
  v = char(javaMethod('getProperty', 'java.lang.System', 'java.version'));
else
  v = missing;
end

end
