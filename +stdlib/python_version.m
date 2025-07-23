%% PYTHON_VERSION get the Python version used by MATLAB
%
%## Output
%* 1x3 vector of major, minor, micro version e.g. Python 3.14.2 = [3, 14, 2]
% we need to do at least one Python function call to handle cases
% where the environment has changed since pyenv() was set. For example
% HPC with "module load python3..."

function v = python_version(force)
arguments
  force (1,1) logical = false
end

v = [];

if isMATLABReleaseOlderThan('R2022a') && ~force
  return
end

% we use a separate function because the JIT compiler in Matlab < R2022a
% breaks try-catch for any py.* command

v = pvt_get_python_version();

end
