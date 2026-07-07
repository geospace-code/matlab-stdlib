%% CREATE_SYMLINK create symbolic link
%
%%% inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * i: true if successful
% * b: backend used

function [i, b] = create_symlink(target, link, backend)
arguments
  target (1,1) string {mustBeFileOrFolder}
  link {mustBeTextScalar,mustBeNonzeroLengthText}
  backend (1,:) string {mustBeNonempty} = ["native", "dotnet", "python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".create_symlink");
  i = f(target, link);

  if ~ismissing(i)
    return
  end
end

end
