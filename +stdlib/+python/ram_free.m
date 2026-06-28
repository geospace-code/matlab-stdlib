function n = ram_free()

if stdlib.has_python() && stdlib.python.has_psutil()
  vm = py.psutil.virtual_memory();
  n = uint64(vm.available);
else
  n = missing;
end

end
