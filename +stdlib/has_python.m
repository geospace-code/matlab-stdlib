%% HAS_PYTHON checks if Python is available in the current environment.
%
% https://www.mathworks.com/support/requirements/python-compatibility.html

function y = has_python()

if isMATLABReleaseOlderThan('R2022b')
  % Matlab this old doesn't work as nice with Python
  % also, R2022b was the first to support Python 3.10
  y = false;
  return
end

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
