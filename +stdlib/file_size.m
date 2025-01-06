% FILE_SIZE size in bytes of file

function s = file_size(p)
arguments
  p (1,1) string
end

s = [];

if ~isfile(p)
  return
else
  s = dir(p);
  if ~isempty(s)
    s = s.bytes;
  end
end

end


%!assert (isempty(file_size('')))
%!assert (file_size('file_size.m') > 0)
