%% EXPANDUSER expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
% the string $HOME is not handled.
%
%%% Inputs
% * file: path to expand, if tilde present
%%% Outputs
% * e: expanded path

function e = expanduser(file)

pat = ['~[/\', filesep, ']+|^~$'];

[i0, i1] = regexp(file, pat, 'once');

if isempty(i0)
  % no leading ~ or it's ~user, which we don't handle
  e = file;
  return
end

home = stdlib.homedir();

if i1 - i0 == 0 || strlength(file) == i1
  e = home;
  if isstring(file)
    e = string(e);
  end
else
  e = append(home, '/', extractAfter(file, i1));
end

end
