%% HAS_PYTHON checks if Python is available in the current environment.
% By default, does not check for Python availability.
% On some systems, Python may be broken in ways not detected by this function.
% The check can be per-session persistently disabled by `stdlib.has_python(false)`.
% The check can be per-session persistently enabled by `stdlib.has_python(true)`.
%
% https://www.mathworks.com/support/requirements/python-compatibility.html
%
% default is enable_check=false because if Python hasn't even been setup with "pyenv", even with
% Matlab R2026a, can get uncatchable error like
%   bad lexical cast: source type value could not be interpreted as target

function y = has_python(enable_check)
arguments
  enable_check (1,1) logical = false
end

persistent py_enable

if ~isempty(py_enable) && nargin == 0
  y = py_enable;
  return
end


if ~enable_check || isMATLABReleaseOlderThan('R2022a')
  y = false;
  py_enable = false;
  return
end

v = stdlib.python.version();
y = ~any(ismissing(v)) & ~isempty(v);

py_enable = y;

end
