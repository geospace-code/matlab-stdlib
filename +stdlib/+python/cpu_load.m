function L = cpu_load()

Lavg = py.os.getloadavg();
L = double(Lavg(1));

end
