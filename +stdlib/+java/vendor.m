%% JAVA.VENDOR get vendor of Java Virtual Machine

function v = vendor()

if stdlib.has_java()
  v = char(javaMethod('getProperty', 'java.lang.System', 'java.vendor'));
else
  v = missing;
end

end
