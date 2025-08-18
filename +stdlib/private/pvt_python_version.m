function v = pvt_python_version()

v = [];

pe = pyenv();
vs = pe.Version;
if stdlib.strempty(vs), return, end

% this line may error like
% "Python Error: TypeError: cannot create 'sys.version_info' instances"
% if Python version incompatible or something got corrupted in loading Python library
% try restarting Matlab
vi = py.sys.version_info;
v = [double(vi.major), double(vi.minor), double(vi.micro)];

vv = strsplit(vs, '.');
assert(str2double(vv{1}) == v(1), "stdlib:python_version:ValueError", "Python major version %s did not match pyenv %d", vv{1}, v(1))
assert(str2double(vv{2}) == v(2), "stdlib:python_version:ValueError", "Python minor version %s did not match pyenv %d", vv{1}, v(1))

end
