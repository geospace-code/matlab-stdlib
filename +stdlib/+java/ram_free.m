function bytes = ram_free()

b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");

if stdlib.java_api() < 14
  bytes = b.getFreePhysicalMemorySize();
else
  bytes = b.getFreeMemorySize();
end

bytes = uint64(bytes);

end
