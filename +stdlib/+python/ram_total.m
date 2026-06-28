function n = ram_total()

if stdlib.has_python()
try
  vm = py.psutil.virtual_memory();
  n = uint64(vm.total);
catch e
  n = pythonException(e);
end
else
  n = missing;
end

end
