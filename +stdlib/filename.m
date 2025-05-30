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

% NOT https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getName()
% because by our definition, a trailing directory component is not part of the filename
% this is like C++17 filesystem::path::filename

parts = strsplit(stdlib.posix(p), '/');

f = parts{end};

if isstring(p)
  f = string(f);
end

end


%!assert (filename('a/b/c.txt'), 'c.txt')
%!assert (filename('a/b/'), '')
