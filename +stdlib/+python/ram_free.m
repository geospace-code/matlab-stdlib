function n = ram_free()

try
  vm = py.psutil.virtual_memory();
  n = vm.available;
catch e
  pythonException(e)
  n = [];
end

n = uint64(n);

end
