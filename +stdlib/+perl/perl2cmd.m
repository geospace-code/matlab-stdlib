function c = perl2cmd(p)
% PERL2CMD prepare Perl cmd for Matlab sprintf
%
% Windows wants double quotes, Unix wants single quotes

if ispc()
  c = sprintf('"%s"', p);
else
  c = sprintf('''%s''', p);
end

end
