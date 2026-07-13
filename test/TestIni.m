classdef (TestTags = {'impure'}) TestIni < StdlibPath


methods (Test)

function test_example(tc)

cwd = fileparts(mfilename('fullpath'));
example = cwd + "/example.ini";

s = stdlib.ini2struct(example);
tc.verifyClass(s, 'struct')
tc.verifyEqual(s.DATA.keyNum, 113);

end

end

end
