function L = cpu_load()


b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");

L = b.getSystemLoadAverage();
if L < 0
  if stdlib.java_api() < 14
    L = b.getSystemCpuLoad();
  else
    % https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getCpuLoad()
    L = b.getCpuLoad();
  end
end

end
