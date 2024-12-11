%% HAS_JAVA detect if JVM is available

function ok = has_java()

persistent h;

if isempty(h)
  h = usejava('jvm');
end

ok = h;

end

%!assert(islogical(has_java()))
