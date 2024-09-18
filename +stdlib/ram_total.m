function bytes = ram_total()
%% ram_total()
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

bytes = b.getTotalPhysicalMemorySize();
% deprecated but Matlab doesn't have Java 14 getPhysicalMemorySize() yet
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()

end
