function N = cpu_count
%CPU_COUNT how many CPUs
N = maxNumCompThreads;
if N < 2  % happens on some HPC
  N = feature('NumCores');
end

% logical CPUs
% N=java.lang.Runtime.getRuntime().availableProcessors();
end