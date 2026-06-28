function t = uptime()

if stdlib.has_python() && stdlib.python.has_psutil()
  t0 = py.psutil.boot_time();
  t = py.time.time() - t0;
else
  t = missing;
end

end
