%% CREATE_SYMLINK create symbolic link
% optional: mex
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
      if stdlib.has_dotnet()
        System.IO.File.CreateSymbolicLink(link, target);
        ok = true;
      else
        ok = false;
      end
    case "Octave:undefined-function"
      err = symlink(target, link);
      ok = err == 0;
    otherwise
      warning(e.identifier, "%s", e.message)
      ok = false;
  end
end

end

%!assert (create_symlink("https://invalid", "https://invalid"), false)
%!test
%! if !ispc
%!   assert(create_symlink(tempname, tempname))
%! endif
