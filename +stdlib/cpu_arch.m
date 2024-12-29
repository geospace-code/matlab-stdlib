%% CPU_ARCH get the CPU architecture

function arch = cpu_arch()

arch = javaSystemProperty("os.arch");

end

%!assert(!isempty(cpu_arch()))
