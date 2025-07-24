function n = py_ram_free()

try
  vm = py.psutil.virtual_memory();
  n = uint64(vm.available);
catch
  n = 0;
end

end
