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

if stdlib.is_absolute(p)
  c = p;
  return
end

c = fullfile(stdlib.absolute(base), p);

end


%!assert(absolute('', ''), pwd)
%!assert(absolute('a/b', ''), fullfile(pwd(), 'a/b'))
