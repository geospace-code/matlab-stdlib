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
  target {mustBeTextScalar,mustBeFileOrFolder}
  link {mustBeTextScalar,mustBeNonzeroLengthText}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, target, link);

end
