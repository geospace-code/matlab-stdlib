function n = ram_total()

if stdlib.python.has_psutil()
  vm = py.psutil.virtual_memory();
  n = uint64(vm.total);
else
  n = missing;
end

end
