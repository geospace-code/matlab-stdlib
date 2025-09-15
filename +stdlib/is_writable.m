%% IS_WRITABLE is path writable
%
%%% Inputs
% * file: path to file or folder
%%% Outputs
% * y: true if file is writable
%
% this method is like 40x faster than native

function y = is_writable(file)

a = file_attributes(file);

if isempty(a)
  y = false;
else
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
end

end
