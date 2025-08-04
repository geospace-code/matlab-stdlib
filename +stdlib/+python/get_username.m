function n = get_username()

try
  n = char(py.getpass.getuser());
catch e
  warning(e.identifier, "get_username(%s) failed: %s", p, e.message);
  n = '';
end

end
