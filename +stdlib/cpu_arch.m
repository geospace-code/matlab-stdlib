%% CPU_ARCH get the CPU architecture
%
%%% Outputs
% * a: Returns the CPU architecture as a string.
% * b: backend used

function [a, b] = cpu_arch(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "native"]
end

o = stdlib.Backend(mfilename(), backend);
a = o.func();

b = o.backend;

end
