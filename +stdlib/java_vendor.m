%% JAVA_VENDOR get vendor of Java Virtual Machine
% requires: java

function v = java_vendor()

v = javaSystemProperty("java.vendor");

end

%!assert(!isempty(java_vendor()))
