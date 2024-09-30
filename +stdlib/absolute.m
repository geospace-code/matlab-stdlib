function c = absolute(p, base, expand_tilde)
%% absolute(p)
% path need not exist
% absolute path will be relative to pwd if not exist
%
%%% Inputs
% * p: path to make absolute
% * base: if present, base on this instead of cwd
% * expand_tilde: expand ~ to username if present
%%% Outputs
% * c: resolved path
% does not normalize
% non-existant path is made absolute relative to pwd
arguments
  p (1,1) string
  base string {mustBeScalarOrEmpty} = string.empty
  expand_tilde (1,1) logical = true
end

if expand_tilde
  c = stdlib.expanduser(p);
else
  c = p;
end

if ~stdlib.is_absolute(c)
  % .getAbsolutePath(), .toAbsolutePath()
  % default is Documents/Matlab, which is probably not wanted.
  if isempty(base) || strlength(base) == 0
    c = stdlib.join(pwd, c);
  else
    c = stdlib.join(stdlib.absolute(base), c);
  end
end

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getAbsolutePath()

c = stdlib.posix(java.io.File(c).getAbsolutePath());

end % function
