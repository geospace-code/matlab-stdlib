function [r, s] =  BenchmarkIsExeRun()
tname = "BenchmarkIsExe";

%% Exist, same
r = run_bench(tname);
s = sampleSummary(r);
disp(sortrows(s, "Median"))

end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(RelativeMarginOfError=0.1);
result = exp.run(suite);
end