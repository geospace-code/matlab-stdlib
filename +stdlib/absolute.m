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
if nargin < 2
  base = pwd();
end

if stdlib.is_absolute(p)
  c = p;
  return
end

% avoid infinite recursion
if stdlib.is_absolute(base)
  c = base;
else
  c = pwd();
  if ~stdlib.strempty(base)
    c = append(c, '/', base);
  end
end

if ~stdlib.strempty(p)
  if endsWith(c, ["/", filesep])
    c = append(c, p);
  else
    c = append(c, '/', p);
  end
end

end
