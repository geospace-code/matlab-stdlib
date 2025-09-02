function [r, s] =  BenchmarkNormalizeRun()
tname = "BenchmarkNormalize";

r = run_bench(tname);
s = sampleSummary(r);
disp(sortrows(s, "Median"))
end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(MaxSamples=150, RelativeMarginOfError=0.05);
result = exp.run(suite);
end
