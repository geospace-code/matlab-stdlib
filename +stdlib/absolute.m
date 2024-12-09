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

cwd = stdlib.posix(pwd());

Lb = stdlib.len(base);

if stdlib.len(p) == 0 && Lb == 0
   c = cwd;
   return
end

if expand_tilde
  c = stdlib.expanduser(p, use_java);
else
  c = p;
end

if stdlib.is_absolute(c, use_java)
  c = stdlib.posix(c);
else
  % .getAbsolutePath(), .toAbsolutePath()
  % default is Documents/Matlab, which is probably not wanted.
  if Lb == 0
    if ischar(cwd)
      c = strcat(cwd, '/', c);
    else
      c = cwd + "/" + c;
    end
  else
    d = stdlib.absolute(base, "", expand_tilde, use_java);
    if isempty(c) || stdlib.len(c) == 0
      c = d;
    else
      if ischar(d)
        c = strcat(d, '/', c);
      else
        c = d + "/" + c;
      end
    end
  end
end

% not needed:
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getAbsolutePath()

end


%!assert(absolute('', '', 0,0), posix(pwd))
%!assert(absolute('a/b', '', 0,0), posix(fullfile(pwd, 'a/b')))
