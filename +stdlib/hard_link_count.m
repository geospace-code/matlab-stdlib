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
  file
  backend (1,:) string = ["java", "python", "sys"]
end

i = [];

for b = backend
  switch b
    case "java"
      i = stdlib.java.hard_link_count(file);
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.hard_link_count(file);
    case "sys"
      i = stdlib.sys.hard_link_count(file);
    otherwise
      error("stdlib:hard_link_count:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
