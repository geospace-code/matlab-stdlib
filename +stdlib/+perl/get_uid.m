function u = get_uid()
% PERL.GET_UID tell UID (numeric) of current user

u = [];
if ispc()
  return
end

exe = stdlib.perl_exe();
if stdlib.strempty(exe)
  return
end

cmd = sprintf('"%s" -e "print $<"', exe);

[s, r] = system(cmd);
if s == 0
  u = str2double(r);
end

end
