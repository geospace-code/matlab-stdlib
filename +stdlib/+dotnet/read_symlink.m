%% DOTNET.READ_SYMLINK resolve the symbolic links of a filepath

function r = read_symlink(file)

r = "";

try
  h = System.IO.FileInfo(file);
  r = string(h.LinkTarget);
  % on Unix, this can be empty if the file is not a symlink
  if isempty(r)
    r = "";
  end
catch e
  dotnetException(e)
end

end
