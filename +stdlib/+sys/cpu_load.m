function L = cpu_load()
%% CPU_LOAD get total physical CPU load
% https://docs.oracle.com/javase/9/docs/api/com/sun/management/OperatingSystemMXBean.html#getSystemCpuLoad--
% Returns the "recent cpu usage" for the whole system.
% This value is a double in the [0.0,1.0] interval.
% A value of 0.0 means that all CPUs were idle during the recent period of time observed, while a value of 1.0 means that all CPUs were actively running 100% of the time during the recent period being observed.
% All values betweens 0.0 and 1.0 are possible depending of the activities going on in the system.
% If the system recent cpu usage is not available, the method returns a negative value.

b = java.lang.management.ManagementFactory.getOperatingSystemMXBean();
L = b.getSystemCpuLoad();

end
