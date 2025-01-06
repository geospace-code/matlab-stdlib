%% CPU_COUNT how many CPUs are available
function N = cpu_count()

N = maxNumCompThreads;

if N < 2 && ~stdlib.isoctave() % happens on some HPC
  N = feature('NumCores');
end

% logical CPUs
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/lang/Runtime.html#getRuntime()
% N=java.lang.Runtime.getRuntime().availableProcessors();
end

%!assert(cpu_count() > 0)
