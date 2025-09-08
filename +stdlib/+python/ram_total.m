function n = ram_total()

try
  vm = py.psutil.virtual_memory();
  n = vm.total;
catch e
  pythonException(e)
  n = [];
end

n = uint64(n);

end
