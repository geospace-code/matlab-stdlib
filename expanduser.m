%!assert(ischar(expanduser('~')))
function expanded = expanduser(p)
% expanded = expanduser(path)
%
%   expands tilde ~ into user home directory for Matlab and GNU Octave.
%
%   Useful for Matlab functions like h5read() and some Computer Vision toolbox functions
%   that can't handle ~ and Matlab does not consider it a bug per conversations with
%   Mathworks staff
%
%  Benchmark: on laptop and Matlab R2020a
%
%   about 200 microseconds
%   f = @() expanduser('~/foo');
%   timeit(f)
%
%   about 2 microseconds:
%   f = @() expanduser('foo');
%   timeit(f)
%
%   See also absolute_path

narginchk(1,1)

if isempty(p)
  expanded = '';
  return
end

validateattributes(p, {'char'}, {'vector'})
%% GNU Octave
if isoctave
  expanded = tilde_expand(p);
  return
end

%% Matlab
expanded = p;

if strcmp(expanded(1), '~')

  home = [];
  if isunix
    home = getenv('HOME');
  elseif ispc
    home = getenv('USERPROFILE');
  end

  if isempty(home)
    % this is 100x slower than getenv() on Matlab R2020a
    home = char(java.lang.System.getProperty("user.home"));
  end

  expanded = fullfile(home, expanded(2:end));
end

end %function
