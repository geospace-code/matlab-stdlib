%% TOOLBOX_USED list all Matlab toolboxes used by all functions in pkgPath
%
%%% inputs
% * pkgPath: path to user namespace or file. Example: 'stdlib' or 'stdlib.cpu_arch'
%%% Outputs
% * tbxMathworks: Mathworks toolbox names used
% * funUser: all user function files under pkgPath

function [tbxMathworks, funUser] = toolbox_used(name)

n = name;

try

  f = namespaceFunctions(name);
  if ~isempty(f)
    n = f(1).NamespaceName + "." + string({f.Name});
  end

catch e

  if ~strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    rethrow(e)
  end

end

if ispc()
  old = getenv('KMP_DUPLICATE_LIB_OK');
  setenv('KMP_DUPLICATE_LIB_OK', 'TRUE');

  % otherwise,
  %   matlab -batch "buildtool test"
  % or
  %   matlab -batch "stdlib.toolbox_used('stdlib')"
  % crash Matlab with:
  %   OMP: Error #15: Initializing libiomp5md.dll, but found libiomp5md.dll already initialized.
  %
  % calling toolbox_used on any one function doesn't fail.
end

try
  [user, mathworks] = matlab.codetools.requiredFilesAndProducts(n);
catch e
  if ispc()
    setenv('KMP_DUPLICATE_LIB_OK', old)
  end
  rethrow(e)
end

if ispc()
  setenv('KMP_DUPLICATE_LIB_OK', old)
end

tbxMathworks = string({mathworks.Name}).';

funUser = string(user).';

end
