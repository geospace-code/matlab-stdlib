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

e = char(file);

pat = ['~[/\', filesep, ']+|^~$'];

[i0, i1] = regexp(e, pat, 'once');

if ~isempty(i0)

  home = stdlib.homedir();

  if i1 - i0 == 0 || length(e) == i1
    e = home;
  else
    e = [home, '/', e(i1+1:end)];
  end

end

if isstring(file)
  e = string(e);
end

end


%!assert(stdlib.expanduser('~'), stdlib.homedir())
%!assert(stdlib.expanduser('~/'), stdlib.homedir())
%!assert(stdlib.expanduser('~/abd'), [stdlib.homedir(), '/abd'])
%!assert(stdlib.expanduser('abc'), 'abc')