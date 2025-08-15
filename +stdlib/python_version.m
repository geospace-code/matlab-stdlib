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

function [v, msg] = python_version(force_old)
if nargin < 1
  force_old = false;
end

persistent stdlib_py_version

msg = '';

if ~isempty(stdlib_py_version)
  v = stdlib_py_version;
  return
end

% Matlab < R2022a has a bug in the JIT compiler that breaks try-catch
% for any py.* command.
% We use a separate private function to workaround that.

v = [];

if stdlib.matlabOlderThan('R2022a') && ~force_old
  return
end

% glitchy Python load can error on sys.version_info
try
  v = pvt_python_version();
catch e
  msg = e.message;
end

% cache the result
if ~isempty(v)
  stdlib_py_version = v;
end

end
