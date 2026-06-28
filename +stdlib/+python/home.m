%% PYTHON.HOME tell the home directory of Python install

function h = home()

try
  pe = pyenv();
  h = pe.Home;
catch e
  h = pythonException(e);
end

end
