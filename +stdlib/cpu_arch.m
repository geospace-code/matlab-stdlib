%% CPU_ARCH get the CPU architecture
% optional: java

function a = cpu_arch()

if stdlib.has_dotnet()
  a = System.Runtime.InteropServices.RuntimeInformation.OSArchitecture;
else
  a = javaMethod("getProperty", "java.lang.System", "os.arch");
end

try  %#ok<*TRYNC>
  a = string(a);
end

end

%!assert(!isempty(cpu_arch()))
