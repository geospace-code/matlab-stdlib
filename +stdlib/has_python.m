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

matlab_too_old = stdlib.matlabOlderThan('R2022a');

% FIXME: update whenever a Windows Matlab ARM64 release is made
windows_arm_mismatch = ispc() && stdlib.shell.cpu_arch() == "ARM64" && computer('arch') == "win64";

if matlab_too_old || windows_arm_mismatch
  if windows_arm_mismatch
    warning('Python check is disabled on Windows ARM64 when Matlab is not ARM64.');
  end
  py_enable = false;
  return
end

if nargin == 0
  enable_check = true;
end

if enable_check
  y = ~isempty(stdlib.python_version());
end

py_enable = y;
end

%!assert(~stdlib.has_python())
