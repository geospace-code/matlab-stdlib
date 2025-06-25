%% ABSOLUTE Determine absolute path
% c = absolute(p);
% Path "p" need not exist.
% Absolute path will be relative to pwd if path does not exist.
%
% c = absolute(p, base);
% the "base" path is used instead of pwd.
%
%%% Inputs
% * p: path to make absolute
% * base: if present, base on this instead of cwd
%%% Outputs
% * c: absolute path
%
% does not normalize path
% non-existant path is made absolute relative to pwd

function c = absolute(p, base)
arguments
  p {mustBeTextScalar}
  base {mustBeTextScalar} = pwd()
end

c = p;
if stdlib.is_absolute(c)
 return
end

if ~strempty(base)
  b = stdlib.absolute(base);
else
  b = pwd();
end

if ~strempty(c)
  c = strcat(b, '/', c);
else
  c = b;
end

if isstring(p) || isstring(base)
  c = string(c);
end

end


%!assert(absolute('', ''), pwd)
%!assert(absolute('a/b', ''), strcat(pwd(), '/a/b'))
