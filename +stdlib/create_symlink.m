%% CREATE_SYMLINK create symbolic link
%
%%% inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * ok: true if successful
% * b: backend used
%
% Some Windows Matlab R2025a give error 'MATLAB:io:filesystem:symlink:NeedsAdminPerms'
% For example, Matlab 25.1.0.2973910 R2025a Update 1 gave this error.

function [ok, b] = create_symlink(target, link, backend)
arguments
  target
  link
  backend (1,:) string = ["native", "dotnet", "python", "sys"]
end


if ismember('native', backend) || stdlib.strempty(backend)
  try
    createSymbolicLink(link, target);
    ok = true;
    b = "native";
    return
  catch e
    switch e.identifier
      case {'MATLAB:UndefinedFunction', 'MATLAB:io:filesystem:symlink:NeedsAdminPerms'}
        % pass through to stdlib.Backend
      case {'MATLAB:io:filesystem:symlink:FileExists', 'MATLAB:io:filesystem:symlink:TargetNotFound'}
        ok = false;
        return
      otherwise
        rethrow(e)
    end
  end

  backend(ismember(backend, 'native')) = [];
end

o = stdlib.Backend(mfilename(), backend);
b = o.backend;
ok = o.func(target, link);

end
