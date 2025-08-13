function bytes = ram_free()

b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

if stdlib.java_api() < 14
  bytes = b.getFreePhysicalMemorySize();
else
  bytes = b.getFreeMemorySize();
end

bytes = uint64(bytes);

end
