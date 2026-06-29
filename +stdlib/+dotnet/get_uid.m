function u = get_uid()

if ispc()
  u = char(System.Security.Principal.WindowsIdentity.GetCurrent().User.Value);
else
  u = missing;
end

end
