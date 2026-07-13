function u = get_uid()

u = char(System.Security.Principal.WindowsIdentity.GetCurrent().User.Value);

end
