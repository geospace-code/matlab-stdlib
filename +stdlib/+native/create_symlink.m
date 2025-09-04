function i = create_symlink(target, link)

try
  createSymbolicLink(link, target);
  i = true;
catch e
  switch e.identifier
    case {'MATLAB:UndefinedFunction', 'MATLAB:io:filesystem:symlink:NeedsAdminPerms'}
      i = logical.empty;
    case {'MATLAB:io:filesystem:symlink:FileExists', 'MATLAB:io:filesystem:symlink:TargetNotFound'}
      i = false;
    otherwise
      rethrow(e)
  end
end

end