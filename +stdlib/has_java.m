%% HAS_JAVA detect if JVM is available
%
% Ref: https://www.mathworks.com/help/matlab/ref/usejava.html

function y = has_java()

y = usejava('jvm');

end

%!assert(islogical(stdlib.has_java()))