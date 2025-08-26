function [r, s] =  BenchmarkSamepathRun()
%% Exist, same
r.same = run_bench('BenchmarkSamepath/bench_exist');
s.exist = sampleSummary(r.same);
disp(sortrows(s.exist, "Median"))
%% Exist, different
r.diff = run_bench('BenchmarkSamepath/bench_diff');
s.diff = sampleSummary(r.diff);
disp(sortrows(s.diff, "Median"))
%% Not Exist
r.not = run_bench('BenchmarkSamepath/bench_not_exist');
s.not = sampleSummary(r.not);
disp(sortrows(s.not, "Median"))

end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(MaxSamples=25, RelativeMarginOfError=0.1);
result = exp.run(suite);
end