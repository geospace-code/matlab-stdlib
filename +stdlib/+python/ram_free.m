function n = ram_free()

if stdlib.has_python()
try
  vm = py.psutil.virtual_memory();
  n = uint64(vm.available);
catch e
  n = pythonException(e);
end
else
  n = missing;
end

end
