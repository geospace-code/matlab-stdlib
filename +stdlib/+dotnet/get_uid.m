function u = get_uid()

u = '';

if ispc()
  try
    u = char(System.Security.Principal.WindowsIdentity.GetCurrent().User.Value);
  catch e
    dotnetException(e)
  end
end

end
