%% PYTHON.HAS_PSUTIL is Python psutil module availble

function y = has_psutil()

try
  py.psutil.version_info();
  y = true;
catch
  y = false;
end

end
