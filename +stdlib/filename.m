%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p)
arguments
  p {mustBeTextScalar}
end

f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep())));

end


%!assert (filename('a/b/c.txt'), 'c.txt')
%!assert (filename('a/b/'), '')
