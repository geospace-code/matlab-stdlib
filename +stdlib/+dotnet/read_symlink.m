%% DOTNET.READ_SYMLINK resolve the symbolic links of a filepath

function r = read_symlink(p)

try
  h = System.IO.FileInfo(p);
  r = string(h.LinkTarget);
catch
  r = string.empty;
end

end
