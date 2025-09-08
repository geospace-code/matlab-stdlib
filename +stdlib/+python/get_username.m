function n = get_username()

try
  n = char(py.getpass.getuser());
catch e
  pythonException(e)
  n = '';
end

end
