%% HAS_PYTHON checks if Python is available in the current environment.
%
% https://www.mathworks.com/support/requirements/python-compatibility.html

function y = has_python(enable_check)

y = false;

if nargin == 0
  enable_check = ~stdlib.matlabOlderThan('R2022a');
end

if enable_check
  y = ~isempty(stdlib.python_version());
end

end

%!assert(~stdlib.has_python())
