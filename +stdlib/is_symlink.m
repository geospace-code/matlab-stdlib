%% IS_SYMLINK is path a symbolic link (optional MEX)

function ok = is_symlink(p)
arguments
  p (1,1) string
end


try
  ok = isSymbolicLink(p);
catch e
  if strcmp(e.identifier, "MATLAB:UndefinedFunction")
    ok = java.nio.file.Files.isSymbolicLink(javaPathObject(stdlib.absolute(p, "", false)));
  elseif strcmp(e.identifier, "Octave:undefined-function")
    ok = S_ISLNK(stat(p).mode);
  else
    rethrow(e)
  end
end

end

%!test
%! if !ispc
%! p = tempname();
%! assert(create_symlink(mfilename("fullpath"), p))
%! assert(is_symlink(p))
%! endif
