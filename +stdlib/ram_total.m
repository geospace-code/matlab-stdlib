%% RAM_TOTAL get total physical RAM
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

function bytes = ram_total()

if stdlib.isoctave()
  b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");
else
  b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();
end

if stdlib.java_api() < 14
  bytes = b.getTotalPhysicalMemorySize();
else
  bytes = b.getTotalMemorySize();
end

% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()

end


%!assert(ram_total()>0)
