function L = cpu_load()

if ~ispc()
  L = py.os.getloadavg();
  L = double(L(1));
else
  L = missing;
end

end
