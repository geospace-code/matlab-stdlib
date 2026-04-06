%% HAS_PYTHON checks if Python is available in the current environment.
%
% https://www.mathworks.com/support/requirements/python-compatibility.html

function y = has_python(enable_check)
% arguments
%   enable_check (1,1) logical = ~stdlib.matlabOlderThan('R2022a');
% end

persistent py_enable

if ~isempty(py_enable) && nargin == 0
  y = py_enable;
  return
end

y = false;

if nargin == 0
  enable_check = ~stdlib.matlabOlderThan('R2022a');
end

if enable_check
  y = ~isempty(stdlib.python_version());
end

py_enable = y;

end

%!assert(~stdlib.has_python())
