function pkg_path(tc)
arguments
  tc (1,1) matlab.unittest.TestCase
end

r = fileparts(fileparts(fileparts(mfilename('fullpath'))));

p = matlab.unittest.fixtures.PathFixture(r);

tc.applyFixture(p)

end
