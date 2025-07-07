%% EXPANDUSER expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * e: expanded path

function e = expanduser(p)
arguments
  p {mustBeTextScalar}
end

e = char(p);

L = length(e);
if L == 0 || e(1) ~= '~' || (L > 1 && ~startsWith(e(1:2), {'~/', ['~', filesep()]}))
  % noop
else
  home = stdlib.homedir();
  if isempty(home)
    % noop
  elseif L < 2
    e = home;
  else
    e = fullfile(home, e(3:end));
  end
end

if isstring(p)
  e = string(e);
end

end


%!assert(expanduser(''), '')
%!assert(expanduser("~"), homedir())
%!assert(expanduser("~/"), homedir())
%!assert(expanduser("~user"), "~user")
%!assert(expanduser("~user/"), "~user/")
%!assert(expanduser("~/c"), fullfile(homedir(), "c"))
