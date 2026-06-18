%% IS_WRITABLE is path writable
%
%%% Inputs
% * file: path to file or folder
%%% Outputs
% * y: true if file is writable

function y = is_writable(file)
arguments
  file {mustBeTextScalar}
end

try
  a = filePermissions(file);
  y = a.Writable;
catch e
  switch e.identifier
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      y = false;
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      a = file_attributes(file);
      y = ~isempty(a) && (a.UserWrite || a.GroupWrite || a.OtherWrite);
    otherwise
      rethrow(e)
  end
end

end
