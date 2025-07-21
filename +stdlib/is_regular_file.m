%% IS_REGULAR_FILE check if path is a regular file
% requires: java

function r = is_regular_file(p)
arguments
  p {mustBeTextScalar}
end

% needs absolute()
p = stdlib.absolute(p, pwd());

op = javaPathObject(p);
opt = javaMethod("values", "java.nio.file.LinkOption");

r = javaMethod("isRegularFile", "java.nio.file.Files", op, opt);

end

%!assert(is_regular_file('is_regular_file.m'))
