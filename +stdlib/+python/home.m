%% PYTHON.HOME tell the home directory of Python install

function h = home()

if stdlib.has_python
  pe = pyenv();
  h = pe.Home;
else
  h = missing;
end

end
