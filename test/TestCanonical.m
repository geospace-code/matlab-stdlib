classdef TestCanonical < WorkingClassDir

properties (TestParameter)
p = {
{'not-exist', "not-exist"}, ...
{'a/../b', "a/../b"}, ...
{'not-exist/a/..', "not-exist/a/.."}, ...
{'./not-exist', "not-exist"}
};
end

methods (Test)
function test_canonical(tc, p)
c = stdlib.canonical(p{1}, false);
tc.verifyEqual(c, p{2})

tc.verifyEqual(stdlib.canonical(string(p{1}), false), string(p{2}))
end

function test_canonical_empty(tc)
pw = string(pwd());
tc.verifyEqual(stdlib.canonical('', false), pw)
tc.verifyEqual(stdlib.canonical('', true), pw)
tc.verifyEqual(stdlib.canonical(""), pw)
end

function test_canonical_strict(tc)
c = stdlib.canonical('.', true);
tc.verifyEqual(c, string(pwd()))

tc.verifyEqual(stdlib.canonical('not-exist', true), missing)
end

end

end
