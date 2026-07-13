%% DOTNET.READ_SYMLINK resolve the symbolic links of a filepath
% .NET >= 6 required

function r = read_symlink(file)

if stdlib.dotnet.api() >= 6
  h = System.IO.FileInfo(file);
  r = string(h.LinkTarget);
  % on Unix, this can be empty if the file is not a symlink
else
  r = missing;
end

end
