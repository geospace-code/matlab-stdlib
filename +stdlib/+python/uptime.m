function t = uptime()

try
  t0 = py.psutil.boot_time();
  t = py.time.time() - t0;
catch
  t = [];
end

end