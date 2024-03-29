function c = normalize(p)
%% normalize(p)
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path

arguments
  p (1,1) string
end

c = stdlib.fileio.normalize(p);

end
