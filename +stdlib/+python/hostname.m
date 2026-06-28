function n = hostname()

if stdlib.has_python()
  n = char(py.socket.gethostname());
else 
  n = missing;
end

end
