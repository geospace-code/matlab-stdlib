function n = hostname()

try
  n = char(py.socket.gethostname());
catch e
  pythonException(e)
  n = missing;
end

end
