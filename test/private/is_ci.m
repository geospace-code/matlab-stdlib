function ok = is_ci()

ok = getenv('CI') == "true" || getenv('GITHUB_ACTIONS') == "true";

end
