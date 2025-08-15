function n = hostname()

try
  n = char(py.socket.gethostname());
catch e
  warning(e.identifier, "get_hostname failed: %s", e.message);
  n = string.empty;
end
