function v = pvt_python_version()

v = [];

pe = pyenv();
vs = pe.Version;
if stdlib.strempty(vs)
  return
end

% check with Python basic type to check this Python version is compatible with Matlab.
% for example, Python 3.13 isn't compatible with Matlab R2025a, and this should catch that.
% by PythonError ImportError: PyCapsule_Import could not import module "libmwbuffer"'
try
  py.tuple([1,1])
catch
  return
end

% this line may error like
% "Python Error: TypeError: cannot create 'sys.version_info' instances"
% if Python version incompatible or something got corrupted in loading Python library
% try restarting Matlab
vi = py.sys.version_info;
v = [double(vi.major), double(vi.minor), double(vi.micro)];

vv = split(vs, ".");
assert(str2double(vv(1)) == v(1), "stdlib:python_version:ValueError", "Python major version %s did not match pyenv %d", vv(1), v(1))
assert(str2double(vv(2)) == v(2), "stdlib:python_version:ValueError", "Python minor version %s did not match pyenv %d", vv(2), v(2))

end
