function bytes = ram_free()

try
  b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

  if stdlib.java_api() < 14
    bytes = b.getFreePhysicalMemorySize();
  else
    bytes = b.getFreeMemorySize();
  end
catch e
  javaException(e)
  bytes = uint64.empty;
end

bytes = uint64(bytes);

end
