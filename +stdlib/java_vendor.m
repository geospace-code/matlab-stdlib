%% JAVA_VENDOR get vendor of Java Virtual Machine

function v = java_vendor()

v = javaMethod("getProperty", "java.lang.System", "java.vendor");

try  %#ok<*TRYNC>
  v = string(v);
end

end

%!assert(!isempty(java_vendor()))
