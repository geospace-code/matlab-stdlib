function bytes = ram_free()

try
  b = javaMethod('getOperatingSystemMXBean', 'java.lang.management.ManagementFactory');

  if stdlib.java_api() < 14
    bytes = b.getFreePhysicalMemorySize();
  else
    bytes = b.getFreeMemorySize();
  end
catch e
  javaException(e)
  bytes = [];
end

bytes = uint64(bytes);

end
