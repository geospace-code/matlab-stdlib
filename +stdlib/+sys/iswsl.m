function yeswsl = iswsl()
persistent wsl;

if isempty(wsl)
  wsl = false;
  yeswsl = false;
  if isunix && ~ismac
    fid = fopen('/proc/version');
    if fid < 1
      return
    end
    v = fscanf(fid,'%s');
    fclose(fid);
    wsl = contains(v, 'microsoft-standard');
  end
end

yeswsl=wsl; % has to be a separate line/variable for matlab

end
