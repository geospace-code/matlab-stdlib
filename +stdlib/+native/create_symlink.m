function ok = create_symlink(target, link)

try
  createSymbolicLink(link, target);
  ok = true;
catch e
  switch e.identifier
    % Some Windows R2025a need admin perms, some don't
    case {'MATLAB:io:filesystem:symlink:FileExists', ...
          'MATLAB:io:filesystem:symlink:TargetNotFound', ...
          'MATLAB:io:filesystem:symlink:NeedsAdminPerms'}
      ok = false;
    otherwise, rethrow(e)
  end
end

end
