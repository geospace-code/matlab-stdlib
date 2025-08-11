%% CREATE_SYMLINK create symbolic link
%
%% Inputs
% * target: path to link to
% * link: path to create link at
%% Outputs
% * ok: true if successful
% * b: backend used

function [ok, b] = create_symlink(target, link, backend)
arguments
  target {mustBeTextScalar}
  link {mustBeTextScalar}
  backend (1,:) string = ["native", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "create_symlink", 'R2024b');

ok = fun(target, link);

end
