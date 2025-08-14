function bench_is_exe()

in = mfilename("fullpath") + ".m";
r = fileparts(fileparts(in));
addpath(r)
obj = onCleanup(@() rmpath(r));

ff = @() stdlib.is_exe(in);
fn = @() stdlib.native.is_exe(in);
fl = @() stdlib.legacy.is_exe(in);
fj = @() stdlib.java.is_exe(in);
fp = @() stdlib.python.is_exe(in);

tj = timeit(fj) * 1e3;
tp = timeit(fp) * 1e3;
tf = timeit(ff) * 1e3;
tn = timeit(fn) * 1e3;
tl = timeit(fl) * 1e3;

fprintf('Full: %f\nNative: %f\nLegacy: %f\nJava: %f\nPython: %f\n', tf, tl, tn, tj, tp);

end