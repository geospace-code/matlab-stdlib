function n = ram_total()

try
  vm = py.psutil.virtual_memory();
  n = vm.total;
catch
  n = 0;
end

n = uint64(n);

end
