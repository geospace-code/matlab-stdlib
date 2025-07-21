%% CPU_ARCH get the CPU architecture
% optional: java

function arch = cpu_arch()

if NET.isNETSupported()
  arch = string(System.Runtime.InteropServices.RuntimeInformation.OSArchitecture);
else
  arch = javaSystemProperty("os.arch");
end

end

%!assert(!isempty(cpu_arch()))
