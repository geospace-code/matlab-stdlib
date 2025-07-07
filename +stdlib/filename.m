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

if isunix()
  pat = '[^/]*$';
else
  pat = '[^/\\]*$';
end

m = regexp(p, pat, 'match', 'once');

if isstring(p) && ismissing(m)
  f = "";
else
  f = m;
end

end


%!assert (filename('a/b/c.txt'), 'c.txt')
%!assert (filename('a/b/'), '')
