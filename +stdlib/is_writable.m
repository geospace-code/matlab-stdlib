%% IS_WRITABLE is path writable

function ok = is_writable(p)

try
  props = "Writable";
  if isunix
    props = [props, "GroupWrite", "OtherWrite"];
  end
  t = getPermissions(filePermissions(p), props);
  ok = any(t{:,:}, 2);
catch e
  switch e.identifier
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      a = file_attributes_legacy(p);
      ok = a.UserWrite || a.GroupWrite || a.OtherWrite;
    otherwise, rethrow(e)
  end
end

end
%!assert (is_writable('is_writable.m'))
