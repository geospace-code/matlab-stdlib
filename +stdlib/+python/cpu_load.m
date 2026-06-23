function L = cpu_load()

L = missing;

try %#ok<TRYNC>
  L = py.os.getloadavg();
  L = double(L(1));
end

end
