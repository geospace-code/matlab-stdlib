function b = javaOSBean()

if stdlib.isoctave()
  b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");
else
  b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();
end

end
