%% HAS_PYTHON checks if Python is available in the current environment.

function y = has_python()

try
  pe = pyenv();
catch e
  switch e.identifier
    case {'Octave:undefined-function', 'MATLAB:Python:PythonUnavailable'}
      y = false;
      return
    otherwise
      rethrow(e);
  end
end

y = ~isempty(pe.Version);

end
