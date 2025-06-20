%% GET_SHELL full path to currently running shell

function s = get_shell()

if ispc()
% https://stackoverflow.com/a/61469226
  cmd = "(dir 2>&1 *`|echo CMD);&<# rem #>echo ($PSVersionTable).PSEdition";
else
% https://askubuntu.com/a/1349538
  cmd = strcat("lsof -p ", '"$$"', " | grep -m 1 txt | xargs -n 1 | tail -n +9 | tr -d [:space:]");
end

[r, msg] = system(cmd);

if r == 0
  s = msg;
else
  s = getenv("SHELL");
end

end

%!assert(ischar(get_shell()))
