%% GET_SHELL full path to currently running shell
%
%%% Outputs
% * s: full path to currently running shell
% * b: backend used

function s = get_shell()

if ispc()
% https://stackoverflow.com/a/61469226
  cmd = '(dir 2>&1 *`|echo CMD);&<# rem #>echo ($PSVersionTable).PSEdition';
else
% https://askubuntu.com/a/1349538
  cmd = 'lsof -p "$$" | grep -m 1 txt | xargs -n 1 | tail -n +9';
end

[r, msg] = system(cmd);

if r == 0
  s = deblank(msg);
else
  s = getenv("SHELL");
end

end
