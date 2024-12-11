%% IS_REGULAR_FILE check if path is a regular file

function r = is_regular_file(p)
% arguments
%   p (1,1) string
% end

% needs absolute()
p = stdlib.absolute(p, "", false, true);

if stdlib.isoctave()
  opt = javaMethod("values", "java.nio.file.LinkOption");
  op = javaObject("java.io.File", p).toPath();
  r = javaMethod("isRegularFile", "java.nio.file.Files", op, opt);
else
  opt = java.nio.file.LinkOption.values;
  op = java.io.File(p).toPath();
  r = java.nio.file.Files.isRegularFile(op, opt);
end

end

%!assert(is_regular_file('is_regular_file.m'))
