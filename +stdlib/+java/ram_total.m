function bytes = ram_total()
% JAVA.RAM_TOTAL get the total physical RAM
%
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()

try
  b = javaMethod('getOperatingSystemMXBean', 'java.lang.management.ManagementFactory');

  if stdlib.java_api() < 14
    bytes = b.getTotalPhysicalMemorySize();
  else
    bytes = b.getTotalMemorySize();
  end
catch e
  javaException(e)
  bytes = [];
end

bytes = uint64(bytes);

end
