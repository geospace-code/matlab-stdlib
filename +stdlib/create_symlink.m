%% CREATE_SYMLINK create symbolic link
% optional: mex
%
%%% Inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * ok: true if successful
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#createSymbolicLink(java.nio.file.Path,java.nio.file.Path,java.nio.file.attribute.FileAttribute...)

function ok = create_symlink(target, link)
arguments
  target (1,1) string
  link (1,1) string
end

ok = false;

if stdlib.exists(link) || ~stdlib.exists(target) || stdlib.is_url(link), return, end

try
  createSymbolicLink(link, target);
  ok = true;
catch e
  if strcmp(e.identifier, "MATLAB:io:filesystem:symlink:NeedsAdminPerms") || ...
      strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    % windows requires RunAsAdmin
    % https://www.mathworks.com/help/releases/R2024b/matlab/ref/createsymboliclink.html
    % ok = java.nio.file.Files.createSymbolicLink(java.io.File(link).toPath(), java.io.File(target).toPath());
    % Matlab Java doesn't recognize the optional argument omitted.
    % see example/Filesystem.java for this working in plain Java.
    % see example/javaCreateSymbolicLink.m for a non-working attempt in Matlab.

    warning(e.identifier, "buildtool mex  \n%s", e.message)

    ok = false;
  elseif strcmp(e.identifier, "Octave:undefined-function")
    [err, msg] = symlink(target, link);
    ok = err == 0;
    if ~ok
      warning("create_symlink: %s", msg)
    end
  end
end

end

%!assert (create_symlink("https://invalid", "https://invalid"), false)
%!test
%! if !ispc
%!   assert(create_symlink(tempname, tempname))
%! endif
