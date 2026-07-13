function id = get_uid()

m = char(System.Security.Principal.WindowsIdentity.GetCurrent().User.Value);

% Extract the RID (last number in the SID)
tokens = regexp(m, 'S-1-5-\d+(?:-\d+)+-(\d+)', 'tokens', 'once');
if ~isempty(tokens)
  id = tokens{1};
else
  error('stdlib:shell:get_uid', 'Failed to parse RID from SID: %s', m);
end

id = str2double(id);

end
