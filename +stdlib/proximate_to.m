%% PROXIMATE_TO relative path to base
%
%%% Inputs
% * base: directory to which the other path should be relative
% * other: path to be made relative
%%% Outputs
% * rel: relative path from base to other

function rel = proximate_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

rel = stdlib.relative_to(base, other);
if stdlib.strempty(rel)
  rel = other;
end

end
