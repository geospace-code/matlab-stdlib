function n = get_username()

try
  n = char(py.getpass.getuser());
catch e
  n = pythonException(e);
end

end
