%% PERL.GET_UID tell UID (numeric) of current user

function u = get_uid()

u = [];
if ispc()
  return
end

cmd = sprintf('"%s" -e "print $<"', stdlib.perl_exe());

[s, r] = system(cmd);
if s == 0
  u = str2double(r);
end

end
