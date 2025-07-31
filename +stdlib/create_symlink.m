%% CREATE_SYMLINK create symbolic link
%
%%% Inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * ok: true if successful

function ok = create_symlink(target, link, method)
arguments
  target {mustBeTextScalar}
  link {mustBeTextScalar}
  method (1,:) string = ["native", "dotnet", "python", "sys"]
end

fun = choose_method(method, "create_symlink", 'R2024b');

ok = fun(target, link);

end
