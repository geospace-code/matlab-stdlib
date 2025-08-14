function bench_samepath()

in = mfilename("fullpath") + ".m";
in2 = 'Readme.md';
r = fileparts(fileparts(in));
addpath(r)
obj = onCleanup(@() rmpath(r));

f = timeit(@() stdlib.samepath(in, in2)) * 1e3;
n = timeit(@() stdlib.native.samepath(in, in2)) * 1e3;
s = timeit(@() stdlib.sys.samepath(in, in2)) * 1e3;
j = timeit(@() stdlib.java.samepath(in, in2)) * 1e3;
p = timeit(@() stdlib.python.samepath(in, in2)) * 1e3;

fprintf('Full %f\nNative: %f\nSys: %f\nJava: %f\nPython: %f\n', f, n, s, j, p);

end