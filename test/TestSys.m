classdef TestSys < matlab.unittest.TestCase

properties (TestParameter)
fun = {stdlib.iscygwin, stdlib.isoctave, stdlib.is_rosetta, stdlib.isinteractive}
fi32 = {stdlib.is_wsl}
end


methods (Test)

function test_platform_logical(tc, fun)

tc.verifyClass(fun, 'logical')
end

function test_platform_int32(tc, fi32)
tc.verifyClass(fi32, 'int32')
end

end
end
