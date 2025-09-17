%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%%% Outputs
% y: true if file is readable
%
% this method is like 40x faster than native

function y = is_readable(file)

a = file_attributes(file);

if isempty(a)
  y = false;
else
  y = a.UserRead || a.GroupRead || a.OtherRead;
end

end

%!assert (stdlib.is_readable('.'))