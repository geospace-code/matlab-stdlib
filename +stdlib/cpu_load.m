%% CPU_LOAD get total physical CPU load
% Returns the "recent cpu usage" for the whole system.
%
% This value is a double in the [0.0,1.0] interval.
% A value of 0.0 means that all CPUs were idle during the recent period of time observed, while a value of 1.0 means that all CPUs were actively running 100% of the time during the recent period being observed.
% All values betweens 0.0 and 1.0 are possible depending of the activities going on in the system.
% If the system recent cpu usage is not available, the method returns a negative value.

function L = cpu_load()

b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();

if stdlib.java_api() < 14
  % https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getSystemCpuLoad()
  L = b.getSystemCpuLoad();
else
  % https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getCpuLoad()
  L = b.getCpuLoad();
end

end
