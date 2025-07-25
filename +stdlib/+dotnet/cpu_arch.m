function a = cpu_arch()
a = string(System.Runtime.InteropServices.RuntimeInformation.OSArchitecture);
% https://learn.microsoft.com/en-us/dotnet/core/compatibility/interop/7.0/osarchitecture-emulation
end
