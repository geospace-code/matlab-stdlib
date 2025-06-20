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
% * expand_tilde: expand ~ to username if present
%%% Outputs
% * c: absolute path
%
% does not normalize path
% non-existant path is made absolute relative to pwd

function c = absolute(p, base, expand_tilde)
arguments
  p {mustBeTextScalar}
  base {mustBeTextScalar} = ''
  expand_tilde (1,1) logical = true
end

if expand_tilde
  c = stdlib.expanduser(p);
else
  c = p;
end

if stdlib.is_absolute(c)
 return
end

if strlength(base) == 0
  b = pwd();
elseif expand_tilde
  b = stdlib.expanduser(base);
else
  b = base;
end

if ~stdlib.is_absolute(b)
  b = strcat(pwd(), '/', b);
end

if strlength(c) == 0
  c = b;
else
  c = strcat(b, '/', c);
end

if isstring(p)
  c = string(c);
end

end


%!assert(absolute('', '', false), pwd)
%!assert(absolute('a/b', '', false), strcat(pwd(), '/a/b'))
