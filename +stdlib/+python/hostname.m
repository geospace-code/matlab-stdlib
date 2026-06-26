function n = hostname()

try
  n = char(py.socket.gethostname());
catch e
  n = pythonException(e);
end

end
