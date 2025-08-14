function bench_canonical()

in = mfilename("fullpath") + ".m";
r = fileparts(fileparts(in));
addpath(r)
obj = onCleanup(@() rmpath(r));

f = timeit(@() stdlib.canonical(in)) * 1e3;
n = timeit(@() stdlib.native.canonical(in)) * 1e3;
l = timeit(@() stdlib.legacy.canonical(in)) * 1e3;

fprintf('Full %f\nNative: %f\nLegacy: %f\n', f, n, l);

end