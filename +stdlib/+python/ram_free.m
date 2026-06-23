function n = ram_free()

try
  vm = py.psutil.virtual_memory();
  n = uint64(vm.available);
catch e
  pythonException(e)
  n = missing;
end

end
