% this script is run on Azure (or locall)

import matlab.unittest.TestRunner;
import matlab.unittest.Verbosity;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.XMLPlugin;
import matlab.unittest.plugins.codecoverage.CoberturaFormat;

names = ["stdlib.fileio", "stdlib.hdf5nc", "stdlib.sys"];

suite = testsuite(names);

runner = TestRunner.withTextOutput('OutputDetail', Verbosity.Concise);

if any(contains(getenv("CI"), ["TRUE", "true", "1"]))
  mkdir('code-coverage');
  mkdir('test-results');
  runner.addPlugin(XMLPlugin.producingJUnitFormat('test-results/results.xml'));
  runner.addPlugin(CodeCoveragePlugin.forPackage(names, 'Producing', CoberturaFormat('code-coverage/coverage.xml')));
end

results = runner.run(suite);
assert(~isempty(results), "no tests found")

assertSuccess(results)
