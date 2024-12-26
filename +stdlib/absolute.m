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

function c = absolute(p, base, expand_tilde, use_java)
arguments
  p (1,1) string
  base (1,1) string = ""
  expand_tilde (1,1) logical = true
  use_java (1,1) logical = false
end

if expand_tilde
  c = stdlib.expanduser(p, use_java);
else
  c = stdlib.posix(p);
end

if stdlib.is_absolute(c)
 return
end

if stdlib.len(base) == 0
  b = pwd();
elseif expand_tilde
  b = stdlib.expanduser(base, use_java);
else
  b = base;
end
b = stdlib.posix(b);

if stdlib.is_absolute(b)
  c = strcat(b, "/", c);
else
  c = strcat(pwd(), "/", b, "/", c);
end

c = stdlib.drop_slash(c);

end


%!assert(absolute('', '', false), posix(pwd))
%!assert(absolute('a/b', '', false), posix(strcat(pwd(), '/a/b')))
