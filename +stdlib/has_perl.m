%% HAS_PERL checks if Perl is available in the current environment.

function y = has_perl()

y = ~isempty(stdlib.perl_version());

end

%!assert (islogical(stdlib.has_perl()))