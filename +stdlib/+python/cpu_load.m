function L = cpu_load()

if ~ispc() && stdlib.has_python()
  L = py.os.getloadavg();
  L = double(L(1));
else
  L = missing;
end

end
