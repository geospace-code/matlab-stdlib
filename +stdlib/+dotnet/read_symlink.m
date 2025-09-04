%% DOTNET.READ_SYMLINK resolve the symbolic links of a filepath
% .NET >= 6 required

function r = read_symlink(file)

try
  h = System.IO.FileInfo(file);
  r = string(h.LinkTarget);
  % on Unix, this can be empty if the file is not a symlink
catch e
  dotnetException(e)
  r = string.empty;
end

end
