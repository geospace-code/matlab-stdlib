function freebytes = ram_free()
%% ram_free()
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Outputs
% * freebytes: free physical RAM [bytes]


b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

if stdlib.java_api() < 14
  freebytes = b.getFreePhysicalMemorySize();
else
  freebytes = b.getFreeMemorySize();
end

end
