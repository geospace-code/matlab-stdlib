function y = has_python()

try
  pe = pyenv();
catch e
  if strcmp(e.identifier, 'Octave:undefined-function')
    y = false;
    return
  else
    rethrow(e);
  end
end

y = ~isempty(pe.Version);

end
