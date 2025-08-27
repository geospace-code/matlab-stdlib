%% HARD_LINK_COUNT get the number of hard links to a file
%
%%% inputs
% * file: path to check
%%% Outputs
% * c: number of hard links
% * b: backend used
%% Java backend references:
%
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% * https://docs.oracle.com/javase/tutorial/essential/io/links.html

function [c, b] = hard_link_count(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  c = o.func(file);
else
  c = arrayfun(o.func, file);
end

b = o.backend;
end
