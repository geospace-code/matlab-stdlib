%% PYTHON_VERSION get the Python version used by MATLAB
%
% uses persistent variable to cache the Python version.
% If the environment changes, the cached version will be invalid.
% this persistent cache is cleared by 'clear functions'
%
%%% Output
% * v: 1x3 vector of major, minor, micro version e.g. Python 3.14.2 = [3, 14, 2]
%
% we need to do at least one Python function call to handle cases
% where the environment has changed since pyenv() was set. For example
% HPC with 'module load python3...'

function v = python_version()

v = stdlib.python.version();

end
