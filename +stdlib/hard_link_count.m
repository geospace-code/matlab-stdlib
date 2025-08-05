%% HARD_LINK_COUNT get the number of hard links to a file
%
%
%% Java backend references:
%
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% * https://docs.oracle.com/javase/tutorial/essential/io/links.html

function c = hard_link_count(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "sys"]
end

fun = hbackend(backend, "hard_link_count");

c = fun(file);

end
