%% JAVA_VENDOR get vendor of Java Virtual Machine
% requires: java

function v = java_vendor()

v = javaMethod("getProperty", "java.lang.System", "java.vendor");

try  %#ok<*TRYNC>
  v = string(v);
end

end

%!assert(!isempty(java_vendor()))
