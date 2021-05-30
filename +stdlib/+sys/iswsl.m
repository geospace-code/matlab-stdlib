%!assert(islogical(iswsl))

function yeswsl = iswsl()
persistent wsl;

if isempty(wsl)
  if isunix
    fid = fopen('/proc/version');
    v = fscanf(fid,'%s');
    fclose(fid);
    wsl = contains(v, 'Microsoft'); % contains() not in octave
  else
    wsl = false;
  end
end

yeswsl=wsl; % has to be a separate line/variable for matlab

end
