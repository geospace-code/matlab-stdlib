function td = createTempdir(tc)
arguments
  tc (1,1) matlab.unittest.TestCase
end

fx = matlab.unittest.fixtures.WorkingFolderFixture();

tc.applyFixture(fx);

td = fx.Folder;

assert(nargout == 1, "use this function to set a test Property or variable directly")

end
