function ArrayRemove(arrayToRemoveFrom,valueToDelete)
    local j, arrayLenght = 1, #arrayToRemoveFrom;
    for i=1,arrayLenght do
        local currentArrayValue = arrayToRemoveFrom[i]
        if currentArrayValue ~= valueToDelete then
            if (i ~= j) then
                arrayToRemoveFrom[j] = arrayToRemoveFrom[i];
                arrayToRemoveFrom[i] = nil;
            end
            j = j + 1;
        else
            arrayToRemoveFrom[i] = nil;
        end
    end
    return arrayToRemoveFrom
end

function ArrayContains(arrayToCheck, valueToSearch)
	local arrayLenght = #arrayToCheck
    for i = 1,arrayLenght do
        if valueToSearch == arrayToCheck[i] then
            return true
        end
    end
    return false
end

function Log(message,type)
	local timestamp = os.date("%d %b %Y %X")
	if type == "info" then
		print(string.format("%s [INFO] %s",timestamp,message))
	elseif type == "error" then
		print(string.format("%s [ERROR] %s",timestamp,message))
	elseif type == "warning" then
		print(string.format("%s [WARNING] %s",timestamp,message))
	elseif type == "debug" and Config.debug then
		print(string.format("%s [DEBUG] %s",timestamp,message))
	end
end