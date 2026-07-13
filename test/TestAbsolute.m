classdef (TestTags = {'impure'}) TestAbsolute < WorkingClassDir

properties (TestParameter)
p1 = {'', "", "hi", './hi', "../hi"};
p2 = {{'', ''}, {'', 'hi'}, {"hi", ""}, {'there', 'hi'}};
end


methods(Test)

function test_absolute1arg(tc, p1)

if strlength(p1)
  r = stdlib.append(pwd(), '/', p1);
else
  r = pwd();
end

if isstring(p1)
  r = string(r);
end

rabs = stdlib.absolute(p1);

tc.verifyClass(rabs, class(p1))
tc.verifyEqual(rabs, r)
end


function test_absolute2arg(tc, p2)

if strlength(p2{2})
  r = stdlib.append(pwd(), '/', p2{2});
else
  r = pwd();
end

if strlength(p2{1})
  r = stdlib.append(r, '/', p2{1});
end

rabs = stdlib.absolute(p2{1}, p2{2});

tc.verifyClass(rabs, class(p2{1}))
tc.verifyEqual(rabs, r)
end

end

end
