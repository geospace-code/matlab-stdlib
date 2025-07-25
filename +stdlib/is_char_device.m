%% IS_CHAR_DEVICE is path a character device
%
% e.g. NUL, /dev/null
% false if file does not exist

function ok = is_char_device(p)
arguments
  p {mustBeTextScalar}
end

if stdlib.has_python()
  ok = stdlib.python.is_char_device(p);
elseif stdlib.isoctave()
  [s, err] = stat(p);
  ok = err == 0 && S_ISCHR(s.mode);
else
  ok = logical.empty;
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
