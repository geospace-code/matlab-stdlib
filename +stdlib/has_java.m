function ok = has_java()
% HAS_JAVA detect if JVM is available

persistent h;

if isempty(h)
  h = usejava('jvm');
end

ok = h;

end
