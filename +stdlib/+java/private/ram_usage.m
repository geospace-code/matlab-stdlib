function u = ram_usage(v)

% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()


b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

switch v
  case 'total'
    if stdlib.java.api() < 14
      bytes = b.getTotalPhysicalMemorySize();
    else
      bytes = b.getTotalMemorySize();
    end
  case 'free'
    if stdlib.java.api() < 14
      bytes = b.getFreePhysicalMemorySize();
    else
      bytes = b.getFreeMemorySize();
    end
  otherwise, error('unknown ram parameter %s', v)
end

u = uint64(bytes);

end
