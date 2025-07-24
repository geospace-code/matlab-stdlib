function v = version()

% Matlab < R2022a has a bug in the JIT compiler that breaks try-catch
% for any py.* command. We use a separate private function to workaround that.

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
