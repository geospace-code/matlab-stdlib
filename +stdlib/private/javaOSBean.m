function b = javaOSBean()

try
  b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();
catch e
  if strcmp(e.identifier, "Octave:undefined-function")
    b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");
  else
    rethrow(e);
  end
end

end
