%% IS_SYMLINK is path a symbolic link
% optional: mex

function ok = is_symlink(p)
arguments
  p {mustBeTextScalar}
end


try
  ok = isSymbolicLink(p);
catch e
  switch e.identifier
    case "MATLAB:UndefinedFunction", ok = java.nio.file.Files.isSymbolicLink(javaPathObject(stdlib.absolute(p)));
    case "Octave:undefined-function"
      [s, err] = stat(p);
      ok = err == 0 && S_ISLNK(s.mode);
    otherwise, rethrow(e)
  end
end

end

%!test
%! if !ispc
%! p = tempname();
%! assert(create_symlink(mfilename("fullpath"), p))
%! assert(is_symlink(p))
%! endif
