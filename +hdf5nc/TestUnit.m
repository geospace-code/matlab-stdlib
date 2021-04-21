classdef TestUnit < matlab.unittest.TestCase

methods (Test)

function test_expanduser(tc)
tc.verifyEmpty(expanduser(string.empty))
tc.verifyFalse(startsWith(expanduser("~"), "~"))
tc.verifyFalse(any(startsWith(expanduser(["~","~"]), "~")))

a = expanduser(["~", "foo"]);
tc.verifyEqual(a(2), "foo")
tc.verifyNotEqual(a(1), "~")
end

end

end
