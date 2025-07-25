%% PYTHON_VERSION get the Python version used by MATLAB
%
% uses persistent variable to cache the Python version
%
%%% Inputs
% * force_old: (optional) boolean flag to force checking of Python on Matlab < R2022a
%
%%% Output
% * v: 1x3 vector of major, minor, micro version e.g. Python 3.14.2 = [3, 14, 2]
%
% we need to do at least one Python function call to handle cases
% where the environment has changed since pyenv() was set. For example
% HPC with "module load python3..."

function v = python_version(force_old)
arguments
  force_old (1,1) logical = false
end

persistent stdlib_py_version

if ~isempty(stdlib_py_version)
  v = stdlib_py_version;
  return
end

v = [];

% For MATLAB versions older than R2022a, skip Python version check unless force_old is true
if isMATLABReleaseOlderThan('R2022a') && ~force_old
  return
end

% we use a separate function because the JIT compiler in Matlab < R2022a
% breaks for any py.* command when pyenv() is not correctly configured

v = stdlib.python.version();

% cache the result
if ~isempty(v)
  stdlib_py_version = v;
end

end
