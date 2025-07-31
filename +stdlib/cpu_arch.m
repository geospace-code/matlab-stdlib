%% CPU_ARCH get the CPU architecture

function a = cpu_arch(method)
arguments
  method (1,:) string = ["java", "dotnet", "native"]
end

fun = choose_method(method, "cpu_arch");

a = fun();

end
