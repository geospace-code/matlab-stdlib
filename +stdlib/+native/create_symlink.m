function ok = create_symlink(target, link)

try
  createSymbolicLink(link, target);
  ok = true;
catch e
  switch e.identifier
    case {'MATLAB:io:filesystem:symlink:FileExists', 'MATLAB:io:filesystem:symlink:TargetNotFound'}, ok = false;
    otherwise, rethrow(e)
  end
end

end
