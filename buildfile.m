function plan = buildfile
plan = buildplan(localfunctions);
end

function testTask(~)
assertSuccess(runtests('stdlib'))
end
