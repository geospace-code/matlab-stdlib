%% IS_CHAR_DEVICE is path a character device
% e.g. NUL, /dev/null
% false if file does not exist

function ok = is_char_device(p)
arguments
    p (1,1) string
end

if stdlib.isoctave()
  ok = S_ISCHR(stat(p).mode);
else
  ok = is_char_device_mex(p);
end

end

%!assert (!is_exe(''))
%!test
%! if ispc
%!   n = "NUL";
%! else
%!   n = "/dev/null";
%! end
%! assert (is_char_device(n))
