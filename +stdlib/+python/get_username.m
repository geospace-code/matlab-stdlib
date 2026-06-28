function n = get_username()

if stdlib.has_python()
  n = char(py.getpass.getuser());
else
  n = missing;
end

end
