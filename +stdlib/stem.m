%% STEM filename without directory or suffix

function p = stem(p)
% arguments
%   p (1,1) string
% end

[~, p] = fileparts(p);

end

%!assert(stem('/a/b.c'), 'b')
