%% HARD_LINK_COUNT get the number of hard links to a file
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: number of hard links
% * b: backend used
%% Java backend references:
%
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% * https://docs.oracle.com/javase/tutorial/essential/io/links.html

function [i, b] = hard_link_count(file, backend)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
