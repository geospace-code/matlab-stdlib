function bytes = ram_total()
%% ram_total()
% get total physical RAM across operating systems
% Ref: https://docs.oracle.com/javase/9/docs/api/com/sun/management/OperatingSystemMXBean.html
%
%%% Outputs
% * bytes: total physical RAM [bytes]


b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

bytes = b.getTotalPhysicalMemorySize();

end
