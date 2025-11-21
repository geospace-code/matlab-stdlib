function a = cpu_arch()
% DOTNET.CPU_ARCH get the Operating System architecture

a = char(System.Runtime.InteropServices.RuntimeInformation.OSArchitecture);
% https://learn.microsoft.com/en-us/dotnet/core/compatibility/interop/7.0/osarchitecture-emulation
end
