function y = pvt_psutil()

try 
 py.psutil.version_info();
 y = true;
catch
 y = false;
end

end
