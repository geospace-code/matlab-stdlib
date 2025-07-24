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

[~, n, s] = fileparts(p);

f = strcat(n, s);

end


%!assert (filename('a/b/c.txt'), 'c.txt')
%!assert (filename('a/b/'), '')
