%% HAS_JAVA detect if JVM is available
% requires: java

function y = has_java()

y = usejava('jvm');

end

%!assert(islogical(has_java()))
