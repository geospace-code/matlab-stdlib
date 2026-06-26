function n = ram_total()

try
  vm = py.psutil.virtual_memory();
  n = uint64(vm.total);
catch e
  n = pythonException(e);
end

end
