%% TOOLBOX_USED list all Matlab toolboxes used by all functions in pkgPath
%
%%% inputs
% * pkgPath: path to user namespace or file. Example: '+stdlib' or 'stdlib.cpu_arch'
%%% Outputs
% * tbxMathworks: Mathworks toolbox names used
% * funUser: all user function files under pkgPath

function [tbxMathworks, funUser] = toolbox_used(pkgPath)

[user, mathworks] = matlab.codetools.requiredFilesAndProducts(pkgPath);

tbxMathworks = string({mathworks.Name}).';

funUser = string(user).';

end
