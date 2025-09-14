%% PYTHON_HOME tell the home directory of Python install

function h = python_home()

try
  pe = pyenv();
  h = pe.Home;
catch
  h = string.empty;
end

end