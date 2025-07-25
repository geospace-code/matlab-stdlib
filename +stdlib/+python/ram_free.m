function n = ram_free()

try
  vm = py.psutil.virtual_memory();
  n = vm.available;
catch
  n = 0;
end

n = uint64(n);

end
