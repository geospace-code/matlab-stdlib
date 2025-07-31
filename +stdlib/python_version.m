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

% Matlab < R2022a has a bug in the JIT compiler that breaks try-catch
% for any py.* command.
% We use a separate private function to workaround that.

v = [];

if isMATLABReleaseOlderThan('R2022a') && ~force_old
  return
end

% need to have no catch section as glitchy Python load can make TypeError etc.
try %#ok<TRYNC>
  v = pvt_python_version();
end

% cache the result
if ~isempty(v)
  stdlib_py_version = v;
end

end
