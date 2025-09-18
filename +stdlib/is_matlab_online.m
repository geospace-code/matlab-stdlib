%% IS_MATLAB_ONLINE check if running in MATLAB Online
% This function is heuristic check using undocumented environment variables.
% These variables have worked across several Matlab releases, but there isn't a guarantee
% that they will always be present or have the same values.

function y = is_matlab_online()

name = 'MW_DDUX_APP_NAME';
value = 'MATLAB_ONLINE';

y = isunix() && ~ismac() && contains(getenv(name), value);

end
