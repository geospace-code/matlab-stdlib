%% DOTNET.READ_SYMLINK resolve the symbolic links of a filepath

function r = read_symlink(p)

try
  h = System.IO.FileInfo(p);
  r = string(h.LinkTarget);
  % on Unix, this can be empty if the file is not a symlink
catch
  r = "";
end

if isempty(r)
  r = "";
end

end
