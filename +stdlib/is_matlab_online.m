%% IS_MATLAB_ONLINE check if running in MATLAB Online
% This function is heuristic check using undocumented environment variables.
% These variables have worked across several Matlab releases, but there isn't a guarantee
% that they will always be present or have the same values.

function y = is_matlab_online()

y = isunix() && ~ismac();
if ~y, return, end

h = getenv("MW_DDUX_APP_NAME");

if h == "MATLAB_ONLINE"
  y = true;
else
  y = false;
end

end
