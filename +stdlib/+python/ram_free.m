function n = ram_free()

try
  vm = py.psutil.virtual_memory();
  n = uint64(vm.available);
catch e
  n = pythonException(e);
end

end
