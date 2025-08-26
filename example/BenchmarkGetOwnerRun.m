function [r, s] =  BenchmarkGetOwnerRun()
%% Exist
r.same = run_bench('BenchmarkGetOwner/bench_exist');
s.exist = sampleSummary(r.same);
disp(sortrows(s.exist, "Median"))
%% Not Exist
r.not = run_bench('BenchmarkGetOwner/bench_not_exist');
s.not = sampleSummary(r.not);
disp(sortrows(s.not, "Median"))

end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(MaxSamples=25);
result = exp.run(suite);
end