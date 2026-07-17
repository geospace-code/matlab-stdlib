function t = uptime()

t0 = py.psutil.boot_time();
t = py.time.time() - t0;

end
