%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * file: path to file
%%% Outputs
% * s: size in bytes; empty if file does not exist
%
% Matlab < R2018a needs char input

function s = file_size(file)

s = [];

d = dir(file);

if isscalar(d) && ~d.isdir
  s = d.bytes;
end

end


%!assert (isempty(stdlib.file_size('.')))
%!test
%! if isfolder('+stdlib/')  % for use from oruntests('+stdlib')
%! assert (stdlib.file_size('../Readme.md') > 0)
%! end