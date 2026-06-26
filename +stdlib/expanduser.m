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
arguments
  file {mustBeTextScalar}
end

% regex designed to pass-thru ~user
pat = ['~[/\', filesep, ']+|^~$'];

[i0, i1] = regexp(file, pat, 'once');

if isempty(i0)
  e = file;
else
  e = fullfile(stdlib.homedir(), extractAfter(file, i1));
end

end
