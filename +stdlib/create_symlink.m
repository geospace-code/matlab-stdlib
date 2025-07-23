%% CREATE_SYMLINK create symbolic link
%
%%% Inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * ok: true if successful

function ok = create_symlink(target, link)
arguments
  target {mustBeTextScalar}
  link {mustBeTextScalar}
end

ok = false;

try
  createSymbolicLink(link, target);
  ok = true;
catch e
  switch e.identifier
    case {"MATLAB:io:filesystem:symlink:NeedsAdminPerms", "MATLAB:UndefinedFunction"}
    % windows requires RunAsAdmin
    % https://www.mathworks.com/help/releases/R2024b/matlab/ref/createsymboliclink.html
    % ok = java.nio.file.Files.createSymbolicLink(java.io.File(link).toPath(), java.io.File(target).toPath());
    % Matlab Java doesn't recognize the optional argument omitted.
    % see example/Filesystem.java for this working in plain Java.
    % see example/javaCreateSymbolicLink.m for a non-working attempt in Matlab.
      if strempty(target) || strempty(link), return, end

      if stdlib.has_python()
        ok = py_create_symlink(target, link);
      elseif stdlib.dotnet_api() >= 6
        ok = dotnet_create_symlink(target, link);
      else
        ok = system_create_symlink(target, link);
      end
    case "Octave:undefined-function", ok = symlink(target, link) == 0;
    otherwise, warning(e.identifier, "%s", e.message)
  end
end

end


function ok = system_create_symlink(target, link)

if ispc
  cmd = sprintf('pwsh -c "New-Item -ItemType SymbolicLink -Path "%s" -Target "%s""', link, target);
else
  cmd = sprintf('ln -s "%s" "%s"', target, link);
end

% suppress output text on powershell
[stat, ~] = system(cmd);

ok = stat == 0;
end


function ok = dotnet_create_symlink(target, link)

% https://learn.microsoft.com/en-us/dotnet/api/system.io.file.createsymboliclink
try
  System.IO.File.CreateSymbolicLink(link, target);
  ok = true;
catch e
  warning(e.identifier, "%s", e.message)
end

end

%!assert (create_symlink("https://invalid", "https://invalid"), false)
%!test
%! if !ispc
%!   assert(create_symlink(tempname, tempname))
%! endif
