function n = get_hostname()

try
  n = string(py.socket.gethostname());
catch e
  warning(e.identifier, "get_hostname failed: %s", e.message);
  n = string.empty;
end
