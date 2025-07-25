%% CPU_ARCH get the CPU architecture

function a = cpu_arch()

if stdlib.has_dotnet()
  a = stdlib.dotnet.cpu_arch();
elseif stdlib.has_java()
  a = stdlib.java.cpu_arch();
else
  a = computer('arch');
end

try  %#ok<*TRYNC>
  a = string(a);
end

end

%!assert(!isempty(cpu_arch()))
