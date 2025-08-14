function bench_parent()

in = mfilename("fullpath") + ".m";
r = fileparts(fileparts(in));
addpath(r)
obj = onCleanup(@() rmpath(r));

h = @() stdlib.parent(in);
fj = @() javafun.parent(in);
fp = @() python.parent(in);

tj = timeit(fj, 1) * 1e3;
tp = timeit(fp, 1) * 1e3;
th = timeit(h, 1) * 1e3;

fprintf('Native: %f\nJava: %f\nPython: %f\n', th, tj, tp);

end