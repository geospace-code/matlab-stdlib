%% PYTHON_VERSION get the Python version used by MATLAB
%
%## Output
%* 1x3 vector of major, minor, micro version e.g. Python 3.14.2 = [3, 14, 2]
% we need to do at least one Python function call to handle cases
% where the environment has changed since pyenv() was set. For example
% HPC with "module load python3..."

function v = python_version()

v = [];

try
  pe = pyenv();
  vs = pe.Version;
  if strlength(vs) == 0, return, end

  vi = py.sys.version_info;
  v = [double(vi.major), double(vi.minor), double(vi.micro)];

  vv = strsplit(vs, '.');
  assert(str2double(vv{1}) == v(1), "stdlib:python_version:ValueError", "Python major version %s did not match pyenv %d", vv{1}, v(1))
  assert(str2double(vv{2}) == v(2), "stdlib:python_version:ValueError", "Python minor version %s did not match pyenv %d", vv{1}, v(1))
catch e
  switch e.identifier
    case {'Octave:undefined-function', 'MATLAB:Python:PythonUnavailable'}  % pass
    otherwise, rethrow(e)
  end
end

end
