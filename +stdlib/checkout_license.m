function [ok, featureName] = checkout_license(packageName)
% CHECKOUT_LICENSE checkout Matlab license
% NOTE: checking out a license holds that license as long as Matlab is
% running. This could impact other users at an institution with a limited
% number of networked licenses. Only use this function at point-of-use,
% that is, when it's certain the function next called requires this license
% to be checked out.
%
% A simpler way is to just use the desired function enclosed with try-catch
%
% This function better tells that a function can
% be used rather than just checking if the relevant toolbox is installed.

arguments
  packageName (1,1) string
end

ok = false;
featureName = string.empty;

% If ~feature('webui'), Java can crash while checking out the license cache.
% feature('webui') is false for Matlab < R2025a if not using the "New Desktop"
try
  addons = matlab.addons.installedAddons;
  name = addons.Name(strcmpi(addons.Name, packageName));
catch
  versions = ver();
  installedPackages = string({versions.Name});
  name = installedPackages(strcmp(installedPackages, packageName));
end

if isempty(name)
  disp(name + " not installed in Matlab " + matlabRelease().Release+ " at " + matlabroot)
  return
end

if ~usejava('jvm')
  warning('Java must be enabled to lookup license names.')
end

featureName = product2feature(name);

if license('test', featureName)
  ok = license('checkout', featureName);
end

end


function f = product2feature(name)

% https://www.mathworks.com/matlabcentral/answers/195425-how-do-i-get-a-license-feature-name-for-a-toolbox-in-ver#answer_173402
% https://www.mathworks.com/matlabcentral/answers/152553-how-can-i-obtain-a-feature-name-or-product-name-within-matlab#answer_150023
% https://www.mathworks.com/help/matlab/matlab_env/index-of-code-analyzer-checks.html

f = com.mathworks.product.util.ProductIdentifier.get(name).getFlexName().string; %#ok<JAPIMATHWORKS>

end


function p = feature2product(name) %#ok<DEFNU>

p = com.mathworks.product.util.ProductIdentifier.get(name).getName().string; %#ok<JAPIMATHWORKS>

end
