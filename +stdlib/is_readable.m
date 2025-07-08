%% IS_READABLE is file readable

function ok = is_readable(p)

try
  props = "Readable";
  if isunix
    props = [props, "GroupRead", "OtherRead"];
  end
  t = getPermissions(filePermissions(p), props);
  ok = any(t{:,:}, 2);
catch e
  switch e.identifier
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      a = file_attributes_legacy(p);
      ok = a.UserRead || a.GroupRead || a.OtherRead;
    otherwise, rethrow(e)
  end
end

end
%!assert (is_readable('is_readable.m'))
