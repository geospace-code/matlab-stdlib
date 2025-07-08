%% IS_EXE is file executable
%
% false if not a file

function ok = is_exe(p)
arguments
  p string
end
% need to have string array type for p(:)

try
  if isunix
    props = ["UserExecute", "GroupExecute", "OtherExecute"];
  else
    props = "Readable";
  end
  t = getPermissions(filePermissions(p), props);
  ok = isfile(p(:)) & any(t{:,:}, 2);
catch e
  switch e.identifier
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      a = file_attributes_legacy(p);
      ok = isfile(p) && (a.UserExecute || a.GroupExecute || a.OtherExecute);
    otherwise, rethrow(e)
  end
end

end

%!assert (!is_exe("."))
%!assert (is_exe(program_invocation_name))
