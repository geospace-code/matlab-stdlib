%% MATLAB_BIN_PATH give binary paths relevant to Matlab Mex and Engine runs
% These can be used with LIBRARY_PATH, LD_LIBRARY_PATH, PATH, etc.
%
% For testing, these can be used with EnvironmentVariableFixture as shown at
% https://github.com/scivision/matlab-buildtool-mex/blob/main/engine/TestEngine.m

function mpaths = matlab_bin_path()

mpaths.arch = computer('arch');
mpaths.root = matlabroot;

mpaths.bin = fullfile(matlabroot, 'bin');

mpaths.extern_bin = fullfile(matlabroot, 'extern/bin', mpaths.arch);

mpaths.arch_bin = fullfile(mpaths.bin, mpaths.arch);

end
