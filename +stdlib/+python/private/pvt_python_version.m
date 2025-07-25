function v = pvt_python_version()

v = [];

pe = pyenv();
vs = pe.Version;
if strlength(vs) == 0, return, end

vi = py.sys.version_info;
v = [double(vi.major), double(vi.minor), double(vi.micro)];

vv = strsplit(vs, '.');
assert(str2double(vv{1}) == v(1), "stdlib:python_version:ValueError", "Python major version %s did not match pyenv %d", vv{1}, v(1))
assert(str2double(vv{2}) == v(2), "stdlib:python_version:ValueError", "Python minor version %s did not match pyenv %d", vv{1}, v(1))

end
