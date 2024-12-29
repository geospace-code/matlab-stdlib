%% JAVA_VENDOR get vendor of Java Virtual Machine

function v = java_vendor()

v = javaSystemProperty("java.vendor");

end

%!assert(!isempty(java_vendor()))
