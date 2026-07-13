function i = ram_usage(v)

vm = py.psutil.virtual_memory();

switch v
  case 'free', i = vm.available;
  case 'total', i = vm.total;
end

i = uint64(i);
end
