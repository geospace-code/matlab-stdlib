%% HAS_PYTHON checks if Python is available in the current environment.
% By default, does not check for Python availability.
% On some systems, Python may be broken in ways not detected by this function.
% The check can be per-session persistently disabled by `stdlib.has_python(false)`.
% The check can be per-session persistently enabled by `stdlib.has_python(true)`.
%
% https://www.mathworks.com/support/requirements/python-compatibility.html

function y = has_python(enable_check)
arguments
  enable_check (1,1) logical = false
end
% ~stdlib.matlabOlderThan('R2022a')

persistent py_enable

if ~isempty(py_enable) && nargin == 0
  y = py_enable;
  return
end


% FIXME: update whenever a Windows Matlab ARM64 release is made
windows_arm_mismatch = ispc() && stdlib.shell.cpu_arch() == "ARM64" && computer('arch') == "win64";

if ~enable_check || windows_arm_mismatch
  if windows_arm_mismatch
    disp('stdlib.has_python: Python check is disabled on Windows ARM64 when Matlab is not ARM64.');
  end
  y = false;
  py_enable = false;
  return
end

y = ~isempty(stdlib.python_version());

py_enable = y;
end
