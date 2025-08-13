function td = createTempdir(tc)
arguments
  tc (1,1) matlab.unittest.TestCase
end

try
  td = tc.createTemporaryFolder();
catch e
  if e.identifier ~= "MATLAB:noSuchMethodOrField"
    rethrow(e)
  end

  td = tempname();
  [ok, err] = mkdir(td);
  tc.assumeTrue(ok, err)
  tc.addTeardown(@() rmdir(td, 's'))
end

assert(nargout == 1, "use this function to set a test Property or variable directly")

end
