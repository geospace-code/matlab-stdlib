%% JAVA_VENDOR get vendor of Java Virtual Machine

function v = java_vendor()

v = java.lang.System.getProperty('java.vendor');

v = char(v);

end
