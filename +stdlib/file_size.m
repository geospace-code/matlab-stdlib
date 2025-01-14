%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * p: path to file
%%% Outputs
% * s: size in bytes, or empty if file does not exist

function s = file_size(p)
arguments
  p (1,1) string
end

s = [];

if stdlib.is_url(p), return, end

if isfile(p)
  s = dir(p);
  if ~isempty(s)
    s = s.bytes;
  end
end

end


%!assert (isempty(file_size('')))
%!assert (file_size('file_size.m') > 0)
