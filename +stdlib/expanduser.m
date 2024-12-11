%% EXPANDUSER expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * e: expanded path

function e = expanduser(p, use_java)
% arguments
%   p (1,1) string
%   use_java (1,1) logical = false
% end
if nargin < 2, use_java = false; end

e = stdlib.drop_slash(p);

L = stdlib.len(e);
if ~L
  return
end

if ischar(e)
  if e(1) ~= '~' || (L > 1 && e(1) == '~' && e(2) ~= '/')
    return
  end
else
  if ~startsWith(e, "~") || (L > 1 && ~startsWith(e, "~/"))
    return
  end
end

home = stdlib.homedir(use_java);

if ~isempty(home)
  d = home;
  if L < 2
    e = d;
    return
  end

  if ischar(e)
    e = strcat(d, '/', e(3:end));
  else
    e = d + "/" + extractAfter(e, 2);
  end
end

end


%!assert(expanduser(''), '')
%!assert(expanduser("~"), homedir())
%!assert(expanduser("~/"), homedir())
%!assert(expanduser("~user"), "~user")
%!assert(expanduser("~user/"), "~user")
%!assert(expanduser("~///c"), strcat(homedir(), "/c"))
