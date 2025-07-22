%% HAS_PYTHON checks if Python is available in the current environment.
%
% https://www.mathworks.com/support/requirements/python-compatibility.html

function y = has_python()

try
  pe = pyenv();
  y = ~isempty(pe.Version);
catch
  y = false;
end

end
