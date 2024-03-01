function bytes = ram_total()
%% ram_total()
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]


b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

bytes = b.getTotalPhysicalMemorySize(); % deprecated but Matlab R2023b doesn't have getPhysicalMemorySize() yet

end
