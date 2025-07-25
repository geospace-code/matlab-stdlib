function n = get_username()

try
  n = string(py.getpass.getuser());
catch e
  warning(e.identifier, "%s", e.message)
  n = string.empty;
end

end
