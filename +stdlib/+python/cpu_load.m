function L = cpu_load()

L = py.os.getloadavg();
L = double(L(1));

end
