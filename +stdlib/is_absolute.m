%% IS_ABSOLUTE is path absolute
%
% * Windows, absolute paths must be at least 3 character long, starting with a root name followed by a slash
% * non-Windows, absolute paths must start with a slash

function y = is_absolute(p)

y = ~stdlib.strempty(stdlib.root_dir(p));

if ispc() && y
  y = ~stdlib.strempty(stdlib.root_name(p));
end

end

%!assert (~stdlib.is_absolute('a'))