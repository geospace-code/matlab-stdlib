function [id, cmd] = get_uid()

if ispc()
  cmd = 'pwsh -c "[System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value"';
else
  cmd = 'id -u';
end

[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:get_uid', 'Failed to run command: %s: %s', cmd, m);

if ispc()
  % Extract the RID (last number in the SID)
  tokens = regexp(m, 'S-1-5-\d+(?:-\d+)+-(\d+)', 'tokens', 'once');
  if ~isempty(tokens)
    id = tokens{1};
  else
    error('stdlib:shell:get_uid', 'Failed to parse RID from SID: %s', m);
  end
else
  id = deblank(m);
end

id = str2double(id);

end
