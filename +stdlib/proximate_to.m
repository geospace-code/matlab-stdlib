%% PROXIMATE_TO relative path to base
%
%%% Inputs
% * base: directory to which the other path should be relative
% * other: path to be made relative
% * backend: backend to use
%%% Outputs
% * rel: relative path from base to other
% * b: backend used

function [rel, b] = proximate_to(base, other, backend)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
  backend (1,:) string = ["python", "native"]
end

[rel, b] = stdlib.relative_to(base, other, backend);
if stdlib.strempty(rel)
  rel = other;
end

end
