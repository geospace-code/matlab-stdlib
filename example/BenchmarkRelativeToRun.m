function BenchmarkRelativeToRun()
tname = "BenchmarkRelativeTo";

%% Exist, same
r.same = run_bench(tname + "/bench_main");
s.exist = sortrows(sampleSummary(r.same), "Median");
disp(s.exist(:, ["Name", "SampleSize", "Mean", "Median"]))

end


function result = run_bench(name)
suite = testsuite(name);
exp = matlab.perftest.TimeExperiment.limitingSamplingError(RelativeMarginOfError=0.1);
result = exp.run(suite);
end