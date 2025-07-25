%% PROXIMATE_TO relative path to base
%
%%% Inputs
% * base {mustBeTextScalar}
% * other {mustBeTextScalar}
%%% Outputs
% * rel {mustBeTextScalar}

function rel = proximate_to(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end

rel = stdlib.relative_to(base, other);
if strempty(rel)
  rel = other;
end

end
