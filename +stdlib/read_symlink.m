%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab
%
%%% inputs
% * file: path to symbolic link
% * backend: backend to use
%%% Outputs
% * r: target of symbolic link
% * b: backend used

function [r, b] = read_symlink(file, backend)
if nargin < 2
  backend = {'native', 'java', 'python', 'dotnet', 'sys'};
else
  backend = cellstr(backend);
end


r = string.empty;

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case "java"
      r = stdlib.java.read_symlink(file);
    case "native"
      r = stdlib.native.read_symlink(file);
    case "dotnet"
      r = stdlib.dotnet.read_symlink(file);
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      r = stdlib.python.read_symlink(file);
    case "sys"
      r = stdlib.sys.read_symlink(file);
    otherwise
      error("stdlib:read_symlink:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(r)
    return
  end
end

end

%!test
%! pkg load tablicious
%!assert (isempty(stdlib.read_symlink('.')))
