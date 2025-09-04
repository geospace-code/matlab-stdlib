function BenchmarkSamepathRun()
tname = "BenchmarkSamepath";

%% Exist, same
r.same = run_bench(tname + "/bench_exist");
s.exist = sortrows(sampleSummary(r.same), "Median");
disp(s.exist(:, ["Name", "SampleSize", "Mean", "Median"]))
%% Main
r.main = run_bench(tname + "/bench_main");
s.main = sortrows(sampleSummary(r.main), "Median");
disp(s.main(:, ["Name", "SampleSize", "Mean", "Median"]))
%% Exist, different
r.diff = run_bench(tname + "/bench_diff");
s.diff = sortrows(sampleSummary(r.diff), "Median");
disp(s.diff(:, ["Name", "SampleSize", "Mean", "Median"]))
%% Not Exist
r.not = run_bench(tname + "/bench_not_exist");
s.not = sortrows(sampleSummary(r.not), "Median");
disp(s.not(:, ["Name", "SampleSize", "Mean", "Median"]))

end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(RelativeMarginOfError=0.1);
result = exp.run(suite);
end