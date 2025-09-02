function [r, s] =  BenchmarkIsSymlinkRun()
tname = "BenchmarkSymlink";

%% Exist
r.same = run_bench(tname + "/bench_is_symlink_exist");
s.exist = sampleSummary(r.same);
disp(sortrows(s.exist, "Median"))
%% Not Exist
r.not = run_bench(tname + "/bench_is_symlink_not_exist");
s.not = sampleSummary(r.not);
disp(sortrows(s.not, "Median"))

end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(MaxSamples=50, RelativeMarginOfError=0.1);
result = exp.run(suite);
end