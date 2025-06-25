%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * p: path to file
%%% Outputs
% * s: size in bytes, or empty if file does not exist

function s = file_size(p)
arguments
  p {mustBeTextScalar,mustBeFile}
end

s = [];

if stdlib.isoctave()
  [st, err] = stat(p);
  if err == 0
    s = st.size;
  end
else
  d = dir(p);
  if ~isempty(d)
    s = d.bytes;
  end
end

end


%!assert (isempty(file_size('')))
%!assert (file_size('file_size.m') > 0)
