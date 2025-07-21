%% PYTHON_VERSION get the Python version used by MATLAB

function v = python_version()

pe = pyenv();
v = pe.Version;

end
