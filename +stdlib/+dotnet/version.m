function v = version()

if stdlib.has_dotnet()
  vs = System.Environment.Version;
  v = sprintf('%d.%d.%d', vs.Major, vs.Minor, vs.Build);
else
  v = missing;
end

end
