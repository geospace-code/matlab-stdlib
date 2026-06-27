%% JAVA.VENDOR get vendor of Java Virtual Machine

function v = vendor()

try
  v = char(javaMethod('getProperty', 'java.lang.System', 'java.vendor'));
catch e
  v = javaException(e);
end

end
