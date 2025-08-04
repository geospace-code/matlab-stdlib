%% CPU_ARCH get the CPU architecture

function a = cpu_arch(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "native"]
end

fun = hbackend(backend, "cpu_arch");

a = fun();

end
