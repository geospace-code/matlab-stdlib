% FILE_SIZE size in bytes of file

function s = file_size(p, use_java)
arguments
  p (1,1) string {mustBeFile}
  use_java (1,1) logical = false
end

if stdlib.isoctave()
  s = javaObject("java.io.File", p).length();
elseif use_java
% several percent slower than native Matlab
  s = java.io.File(p).length;
else
  s = dir(p);
  if isempty(s)
    s = [];
  else
    s = s.bytes;
  end
end

end


%!assert (file_size(''), 0)
%!assert (file_size('file_size.m') > 0)
