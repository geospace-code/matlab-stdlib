function n = get_username()

try
  n = string(py.getpass.getuser());
catch e
  warning(e.identifier, "get_username(%s) failed: %s", p, e.message);
  n = string.empty;
end

end
