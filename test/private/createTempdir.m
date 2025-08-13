function td = createTempdir(tc)
arguments
  tc (1,1) matlab.unittest.TestCase
end

if stdlib.matlabOlderThan('R2022a')
  td = tempname();
  [ok, err] = mkdir(td);
  tc.assumeTrue(ok, err)
  tc.addTeardown(@() rmdir(td, 's'))
else
  td = tc.createTemporaryFolder();
end

assert(nargout == 1, "use this function to set a test Property or variable directly")

end
