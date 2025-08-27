%% CREATE_SYMLINK create symbolic link
%
%%% inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * ok: true if successful
% * b: backend used

function [ok, b] = create_symlink(target, link, backend)
arguments
  target
  link
  backend (1,:) string = ["native", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
ok = o.func(target, link);

b = o.backend;
end
