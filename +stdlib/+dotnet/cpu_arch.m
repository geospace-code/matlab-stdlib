%% DOTNET.CPU_ARCH get the Operating System architecture

function a = cpu_arch()
a = char(System.Runtime.InteropServices.RuntimeInformation.OSArchitecture);
% https://learn.microsoft.com/en-us/dotnet/core/compatibility/interop/7.0/osarchitecture-emulation
end
