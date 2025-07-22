%% CPU_ARCH get the CPU architecture

function a = cpu_arch()

a = '';

if stdlib.has_dotnet()
  a = System.Runtime.InteropServices.RuntimeInformation.OSArchitecture;
  % https://learn.microsoft.com/en-us/dotnet/core/compatibility/interop/7.0/osarchitecture-emulation
elseif stdlib.has_java()
  a = javaMethod("getProperty", "java.lang.System", "os.arch");
end

try  %#ok<*TRYNC>
  a = string(a);
end

end

%!assert(!isempty(cpu_arch()))
