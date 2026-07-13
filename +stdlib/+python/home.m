%% PYTHON_HOME tell the home directory of Python install

function h = home()

pe = pyenv();
h = pe.Home;

end
