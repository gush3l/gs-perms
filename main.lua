local cachedUsers = {}

GSPerms = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.SaveData)
        SaveCachedPlayers()
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        for _, playerId in ipairs(GetPlayers()) do
            local license
            for _,identifier in pairs(GetPlayerIdentifiers(playerId))do
                if string.sub(identifier, 1, string.len("license:")) == "license:" then
                    license = string.gsub(identifier,"license:","")
                end
            end
            LoadUserToCache(license, playerId)
        end
        Citizen.Wait(1000)
        Log(string.format("GS-Perms started succesfully! Cached %s users!",tostring(#cachedUsers)),"info")
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        SaveCachedPlayers()
    end
end)

AddEventHandler('playerConnecting', function()
    local license
    for _,identifier in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(identifier, 1, string.len("license:")) == "license:" then
            license = string.gsub(identifier,"license:","")
        end
    end
    LoadUserToCache(license, source)
end)

AddEventHandler('playerDropped', function ()
    SaveCachedPlayers()
    local license
    for _,identifier in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(identifier, 1, string.len("license:")) == "license:" then
            license = string.gsub(identifier,"license:","")
        end
    end
    for i=1,#cachedUsers do
        local cachedUser = cachedUsers[i]
        local licenseUser = cachedUser.getLicense()
        if license == licenseUser then
            cachedUsers = ArrayRemove(cachedUsers,cachedUser)
            Log(string.format("Saved data for user license %s and removed them from the cache!",license),"debug")
            return
        end
    end
    Log(string.format("Tried to save data for license %s and remove them from the cache but he didn't exist in the cached users table, wierd!",license),"debug")
end)

function SaveCachedPlayers()
    local cachedUsersLenght = #cachedUsers
    for i=1,cachedUsersLenght do
        local gsUser = cachedUsers[i]
        local groups = gsUser.getGroups()
        local permissions = gsUser.getPermissions()
        local license = gsUser.getLicense()
        local gsUserJSON = gsUser.toJSON()
        MySQL.update('UPDATE `gs-perms` SET permissions = ?, groups = ? WHERE license = ?', {json.encode(permissions),json.encode(groups),license}, function(affectedRows)
            if affectedRows then
                Log(string.format("Saved data for user %s into the database!",gsUserJSON),"debug")
            end
        end)
    end
    Log(string.format("Saved data for %s users into the database!",tostring(#cachedUsers)),"info")
end

function LoadUserToCache(license, playerID)
    MySQL.query('SELECT * FROM `gs-perms` WHERE license = ?',{license}, function(queryResult)
        if #queryResult > 0 then
            for i = 1, #queryResult do
                local user = queryResult[i]
                local gsUser = CreateUser(playerID, license, json.decode(user.permissions), json.decode(user.groups))
                cachedUsers[#cachedUsers+1] = gsUser
                Log(string.format("Cached user: %s",gsUser.toJSON()),"debug")
            end
        else
            MySQL.query('INSERT INTO `gs-perms` SET `license` = ?', {license}, function(result)
                if result then
                    local gsUser = CreateUser(playerID, license, json.decode('["command.help","command.gsperms.version","command.gsperms.info"'), json.decode('["user"]'))
                    cachedUsers[#cachedUsers+1] = gsUser
                    Log(string.format("Created and cached user: %s",gsUser.toJSON()),"debug")
                end
            end)
        end
    end)
end

function GSPerms.GetUserById(source)
    for i=1,#cachedUsers do
        local gsUser = cachedUsers[i]
        if tonumber(gsUser.getSource()) == tonumber(source) then
            return gsUser
        end
    end
    local license
    for _,identifier in pairs(GetPlayerIdentifiers(source))do
        if string.sub(identifier, 1, string.len("license:")) == "license:" then
            license = string.gsub(identifier,"license:","")
            end
        end
    LoadUserToCache(license, source)
    return
end

function GSPerms.SaveData(gsNewUser)
    for i=1,#cachedUsers do
        local gsUserFromCache = cachedUsers[i]
        if gsUserFromCache.getLicense() == gsNewUser.getLicense() then
            cachedUsers[i] = gsNewUser
            Log(string.format("Saved new player data to cache for user: %s",gsNewUser.toJSON()),"debug")
            return
        end
    end
end

