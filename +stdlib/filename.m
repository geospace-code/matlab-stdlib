% FILENAME file name of path
% filename (including suffix) without directory

function f = filename(p)
% arguments
%   p (1,1) string
% end

% NOT https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getName()
% because by our definition, a trailing directory component is not part of the filename
% this is like C++17 filesystem::path::filename

[~, n, e] = fileparts(p);

if ischar(n)
  f = strcat(n, e);
else
  f = n + e;
end

end


%!assert (filename('a/b/c.txt'), 'c.txt')
