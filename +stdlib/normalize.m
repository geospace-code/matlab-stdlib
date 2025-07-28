%% NORMALIZE remove redundant elements of path
% optional: mex
%
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path
%
% MEX code is about 4-5x faster than plain Matlab below

function n = normalize(p)
arguments
  p {mustBeTextScalar}
end

if stdlib.has_java()
  n = stdlib.java.normalize(p);
elseif stdlib.has_python()
  n = stdlib.python.normalize(p);
else
  n = stdlib.native.normalize(p);
end

end


%!testif 0
