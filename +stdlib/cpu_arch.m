function a = cpu_arch()
% CPU_ARCH get the Operating System CPU architecture
%
% This function retrieves the CPU architecture of the current operating system.
% The physical CPU architecture can be obscured and even determining it in high-level
% languages like Python is not exactly trivial.
% This method is as used by
% <https://cmake.org/cmake/help/latest/variable/CMAKE_HOST_SYSTEM_PROCESSOR.html CMake>.
%
%%% Outputs
% * a: the CPU architecture as a character vector:

if ispc()
  a = getenv('PROCESSOR_ARCHITECTURE');
else
  [~, a] = system('uname -m');
  a = deblank(a);
end

end

%!assert (~isempty(stdlib.cpu_arch()))
