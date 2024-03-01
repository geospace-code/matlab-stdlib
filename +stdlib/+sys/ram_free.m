function freebytes = ram_free()
%% ram_free()
% get free physical RAM across operating systems
% Ref: https://docs.oracle.com/javase/9/docs/api/com/sun/management/OperatingSystemMXBean.html
%
%%% Outputs
% * freebytes: free physical RAM [bytes]


b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

freebytes = b.getFreePhysicalMemorySize();

end
