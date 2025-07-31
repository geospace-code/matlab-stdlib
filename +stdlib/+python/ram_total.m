function n = ram_total()

try
  vm = py.psutil.virtual_memory();
  n = vm.total;
catch e
  warning(e.identifier, 'stdlib.python.ram_total() failed: %s', e.message)
  n = 0;
end

n = uint64(n);

end
