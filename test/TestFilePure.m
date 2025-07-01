classdef TestFilePure < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", ""}, {"a/b", ""}, {'/etc', ''}}
pu = {{"c:/etc", ""}}
pw = {{"c:/etc", "c:"}}
end


methods (Test, TestTags="pure")

function test_posix(tc)

tc.verifyEqual(stdlib.posix(''), '')
tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyEqual(stdlib.posix("c:\abc"), "c:/abc")
end

end

function test_root_name(tc, p)
tc.verifyEqual(stdlib.root_name(p{1}), p{2})
end
end

methods(Test, TestTags=["pure", "unix"])
function test_root_name_unix(tc, pu)
tc.assumeTrue(isunix)
tc.verifyEqual(stdlib.root_name(pu{1}), pu{2})
end
end

methods(Test, TestTags=["pure", "windows"])
function test_root_name_windows(tc, pw)
tc.assumeTrue(ispc, "This test is only for Windows")
tc.verifyEqual(stdlib.root_name(pw{1}), pw{2})
end
end

end
