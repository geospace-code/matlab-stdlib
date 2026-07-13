classdef (TestTags = {'pure'}) TestWithSuffix < StdlibPath


properties (TestParameter)
p = {{'foo.h5', '.nc', 'foo.nc'},...
{'c', '', 'c'}, ...
{'c.nc', '', 'c'}, ...
{'', '.nc', '.nc'}, ...
{'hello.txt.gz', '.bz', 'hello.txt.bz'}, ...
{'a/b.c/hello.txt', '.gz', 'a/b.c/hello.gz'}, ...
{'a/b/', '.h5', 'a/b/.h5'}, ...
{'a/b/.h5', '.nc', 'a/b/.h5.nc'}, ...
{'.h5', '.nc', '.h5.nc'}, ...
{'a/b', '.nc', 'a/b.nc'}};
end


methods (Test)

function test_with_suffix(tc, p)
tc.verifyEqual(stdlib.with_suffix(p{1}, p{2}), p{3})

tc.verifyEqual(stdlib.with_suffix(string(p{1}), p{2}), string(p{3}))
tc.verifyEqual(stdlib.with_suffix(p{1}, string(p{2})), string(p{3}))
tc.verifyEqual(stdlib.with_suffix(string(p{1}), string(p{2})), string(p{3}))
end

end

end
