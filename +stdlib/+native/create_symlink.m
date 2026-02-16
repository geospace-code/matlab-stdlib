function i = create_symlink(target, link)

try
  createSymbolicLink(link, target);
  i = true;
catch e
  switch e.identifier
    case {'MATLAB:io:filesystem:symlink:NeedsAdminPerms'}
      if ispc
        error('MATLAB:io:filesystem:symlink:NeedsAdminPerms', ...
            'Consider enabling Windows Developer Mode to allow non-priviliged symlinks https://learn.microsoft.com/en-us/windows/advanced-settings/developer-mode#enable-developer-mode')
      else
        rethrow(e)
      end
    case {'MATLAB:UndefinedFunction'}
      i = logical([]);
    case {'MATLAB:io:filesystem:symlink:FileExists', 'MATLAB:io:filesystem:symlink:TargetNotFound'}
      i = false;
    otherwise
      rethrow(e)
  end
end

end
