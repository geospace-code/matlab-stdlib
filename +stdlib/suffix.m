%% SUFFIX last suffix of filename

function s = suffix(p)
% arguments
%   p (1,1) string
% end

[~, ~, s] = fileparts(p);

end

%!assert (suffix('/a/b.c'), '.c')
