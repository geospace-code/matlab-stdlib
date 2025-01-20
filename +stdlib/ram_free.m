%% RAM_FREE get free physical RAM
% requires: java
%
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Outputs
% * freebytes: free physical RAM [bytes]

function freebytes = ram_free()

b = javaOSBean();

if stdlib.java_api() < 14
  freebytes = b.getFreePhysicalMemorySize();
else
  freebytes = b.getFreeMemorySize();
end

end

%!assert(ram_free()>0)
