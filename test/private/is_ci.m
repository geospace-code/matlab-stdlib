function ok = is_ci()

ok = strcmp(getenv('CI'), 'true') || ...
     strcmp(getenv('GITHUB_ACTIONS'), 'true');

end
