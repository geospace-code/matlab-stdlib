%% PYTHON_VERSION get the Python version used by MATLAB

function v = python_version()

try
  pe = pyenv();
  v = pe.Version;
catch
  v = "";
end

end
