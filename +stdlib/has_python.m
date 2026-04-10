%% HAS_PYTHON checks if Python is available in the current environment.
% By default, Matlab >= R2022a will check for Python availability.
% On some systems, Python may be broken in ways not detected by this function.
% The check can be per-session persistently disabled by `stdlib.has_python(false)`.
% The check can be per-session persistently enabled by `stdlib.has_python(true)`.
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
