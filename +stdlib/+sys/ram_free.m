function freebytes = ram_free()
%% ram_free()
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Outputs
% * freebytes: free physical RAM [bytes]


b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

freebytes = b.getFreePhysicalMemorySize(); % deprecated but Matlab R2023b doesn't have getFreeMemorySize()

end
