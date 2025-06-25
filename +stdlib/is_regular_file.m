%% IS_REGULAR_FILE check if path is a regular file
% requires: java

function r = is_regular_file(p)
arguments
  p {mustBeTextScalar}
end

% needs absolute()
p = stdlib.absolute(p, pwd());

op = javaPathObject(p);
opt = javaLinkOption();

if stdlib.isoctave()
  r = javaMethod("isRegularFile", "java.nio.file.Files", op, opt);
else
  r = java.nio.file.Files.isRegularFile(op, opt);
end

end

%!assert(is_regular_file('is_regular_file.m'))
