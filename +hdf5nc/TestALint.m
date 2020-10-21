classdef TestALint < matlab.unittest.TestCase

properties
TestData
end

methods (TestClassSetup)

function get_files(tc)
import matlab.unittest.constraints.IsFile
import matlab.unittest.constraints.IsFolder

cwd = fileparts(mfilename('fullpath'));
folder = fullfile(cwd, '..');
cfg_file = fullfile(cwd, "MLint.txt");

tc.assumeThat(folder, IsFolder)
tc.assumeThat(cfg_file, IsFile)

tc.TestData.folder = folder;
tc.TestData.cfg_file = cfg_file;

flist = dir(tc.TestData.folder + "/**/*.m");
N = length(flist);
tc.assumeGreaterThan(N, 0)

tc.TestData.flist = flist;
tc.TestData.N = N;
end

end

methods (Test)

function test_lint(tc)

flist = tc.TestData.flist;

for i = 1:tc.TestData.N
  file = fullfile(flist(i).folder, flist(i).name);

  res = checkcode(file, "-config=" + tc.TestData.cfg_file, "-fullpath");

  for j = 1:length(res)
    tc.verifyFail(append(file, ":", int2str(res(j).line), " ", res(j).message))
  end
end

end

end

end
