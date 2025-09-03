%% PERL.NORMALIZE normalize path
%
% Note: on Windows, walks up ".." despite specification and not doing so on Unix,
% so we only allow this backend on Unix-like systems

function n = normalize(apath)

n = string.empty;

exe = stdlib.perl_exe();
if stdlib.strempty(exe)
  return
end

cmd = sprintf('"%s" -MFile::Spec -e "print File::Spec->canonpath( ''%s'' )"', exe, apath);

[s, r] = system(cmd);
if s == 0
  n = string(r);
  if strlength(n) == 0
    n = ".";
  end
else
  n = string.empty;
end

end
