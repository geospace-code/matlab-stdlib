%% IS_READABLE is file readable
%
%%% Inputs
% * file: single path string
%%% Outputs
% * y: true if file is readable

function y = is_readable(file)

try
  a = filePermissions(file);
  y = a.Readable;
catch e
  switch e.identifier
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      y = false;
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      a = file_attributes(file);
      y = ~isempty(a) && (a.UserRead || a.GroupRead || a.OtherRead);
    otherwise
      rethrow(e)
  end
end

end

%!assert (stdlib.is_readable('.'))
