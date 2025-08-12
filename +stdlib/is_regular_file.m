%% IS_REGULAR_FILE check if path is a regular file
% requires: java

function r = is_regular_file(file)
% needs absolute()
file = stdlib.absolute(file);

op = javaPathObject(file);
opt = java.nio.file.LinkOption.values();

r = java.nio.file.Files.isRegularFile(op, opt);

end
