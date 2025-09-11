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
  p (1,1) string
  base (1,1) string = pwd()
end

i = stdlib.is_absolute(p);
c(i) = p(i);

% avoid infinite recursion
if ~stdlib.is_absolute(base)
  base = fullfile(pwd(), base);
end

i = ~i;
c(i) = base;

i = i & ~stdlib.strempty(p);
c(i) = fullfile(base, p(i));

end
