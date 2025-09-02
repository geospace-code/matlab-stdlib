%% PERL2CMD prepare Perl cmd for Matlab sprintf
%
% Windows wants double quotes, Unix wants single quotes

function c = perl2cmd(p)

if ispc()
  c = sprintf('"%s"', p);
else
  c = sprintf('''%s''', p);
end

end