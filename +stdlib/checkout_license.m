%% CHECKOUT_LICENSE checkout Matlab license
% NOTE: checking out a license holds that license as long as Matlab is
% running. This could impact other users at an institution with a limited
% number of networked licenses. Only use this function at point-of-use,
% that is, when it's certain the function next called requires this license
% to be checked out.
%
% This function provides a more accurate indicator that a function can
% be used rather than just checking if the relevant toolbox is installed.

function [ok, featureName] = checkout_license(packageName)
arguments
  packageName {mustBeTextScalar}
end

ok = false;

addons = matlab.addons.installedAddons;
installedPackages = addons.Name;
name = addons.Name(strcmpi(installedPackages, packageName));

if isempty(name), return, end

if ~usejava('jvm')
  warning('stdlib:checkout_license:EnvironmentError', 'Java must be enabled to lookup license names.')
  return
end

% https://www.mathworks.com/help/matlab/matlab_env/index-of-code-analyzer-checks.html
featureName = string(com.mathworks.product.util.ProductIdentifier.get(name).getFlexName()); %#ok<JAPIMATHWORKS>

ok = license('checkout', featureName);

end
