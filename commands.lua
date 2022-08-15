RegisterCommand(
    "gsperms",
    function(source, args, rawCommand)
        if (source > 0) then
            local sourceUser = GSPerms.GetUserById(source)
            if sourceUser.hasPermission("gsperms.commands.admin") then
                if #args == 1 and args[1] == "help" then
                    ChatMessage(source, "")
                    ChatMessage(
                        source,
                        "^7^*Use the command in the server console or check the docs for a complete explanation on these commands!"
                    )
                    ChatMessage(source, "^2^*/gsperms user <Player ID> info^r")
                    ChatMessage(source, "^2^*/gsperms user <Player ID> permission add <Permission Node>^r")
                    ChatMessage(source, "^2^*/gsperms user <Player ID> permission remove <Permission Node>^r")
                    ChatMessage(source, "^2^*/gsperms user <Player ID> group add <Group Name>^r")
                    ChatMessage(source, "^2^*/gsperms user <Player ID> group remove <Group Name>^r")
                    ChatMessage(source, "^2^*/gsperms group <Group Name> info^r")
                    ChatMessage(source, "^2^*/gsperms group <Group Name> permission add <Permission Node>^r")
                    ChatMessage(source, "^2^*/gsperms group <Group Name> permission remove <Permission Node>^r")
                    ChatMessage(source, "")
                elseif #args >= 2 and args[1] == "user" then
                    if GetPlayerName(args[2]) == nil then
                        ChatMessage(source, "Specified player ID it's invalid. Is the player offline?^r")
                        return
                    end
                    local targetID = args[2]
                    local gsUser = GSPerms.GetUserById(targetID)
                    if #args == 3 and args[3] == "info" then
                        ChatMessage(source, "^7User Info^r")
                        ChatMessage(source, string.format("Name: ^2^*%s^r", GetPlayerName(targetID)))
                        ChatMessage(source, string.format("IP: ^2^*%s^r", GetPlayerEndpoint(targetID)))
                        ChatMessage(
                            source,
                            string.format("Permissions: ^2^*%s^r", table.concat(gsUser.getPermissions(), ", "))
                        )
                        ChatMessage(source, string.format("Groups: ^2^*%s^r", table.concat(gsUser.getGroups(), ", ")))
                        return
                    end
                    if #args == 5 then
                        if args[3] == "permission" then
                            local permissionNode = args[5]
                            if args[4] == "add" then
                                gsUser.addPermission(permissionNode)
                                ChatMessage(
                                    source,
                                    string.format(
                                        "^2Added^7 the permission node %s to the player with the ID %s!^r",
                                        permissionNode,
                                        targetID
                                    )
                                )
                                GSPerms.SaveData(gsUser)
                                return
                            elseif args[4] == "remove" then
                                gsUser.removePermission(permissionNode)
                                ChatMessage(
                                    source,
                                    string.format(
                                        "^8Removed^7 the permission node %s from the player with the ID %s!^r",
                                        permissionNode,
                                        targetID
                                    )
                                )
                                GSPerms.SaveData(gsUser)
                                return
                            end
                        elseif args[3] == "group" then
                            local groupName = args[5]
                            if args[4] == "add" then
                                gsUser.addGroup(groupName)
                                ChatMessage(
                                    source,
                                    string.format(
                                        "^2Added^7 the group %s to the player with the ID %s!^r",
                                        groupName,
                                        targetID
                                    )
                                )
                                GSPerms.SaveData(gsUser)
                                return
                            elseif args[4] == "remove" then
                                gsUser.removeGroup(groupName)
                                ChatMessage(
                                    source,
                                    string.format(
                                        "^8Removed^7 the group %s from the player with the ID %s!^r",
                                        groupName,
                                        targetID
                                    )
                                )
                                GSPerms.SaveData(gsUser)
                                return
                            end
                        end
                    end
                elseif args[1] == "group" then
                    --
                    -- GROUP COMMANDS
                    --
                end
                ChatMessage(source, "Invalid command! Please use ^2^*/gsperms help^7^r to see full list of commands!^r")
                return
            else
                ChatMessage(source, "You don't have the permission to execute this command!^r")
                return
            end
        else
            if #args == 1 and args[1] == "help" then
                print("")
                print("^2/gsperms user <Player ID> info")
                print(
                    "    ^7Get full permissions specifically assigned to this Player ID and all their assigned groups^r"
                )
                print("")
                print("^2/gsperms user <Player ID> permission add <Permission Node>^r")
                print("    ^7Adds a permission node to the specified Player ID^r")
                print("")
                print("^2/gsperms user <Player ID> permission remove <Permission Node>^r")
                print("    ^7Removes a permission node from the specified Player ID^r")
                print("")
                print("^2/gsperms user <Player ID> group add <Group Name>^r")
                print("    ^7Adds a group to a specified Player ID^r")
                print("")
                print("^2/gsperms user <Player ID> group remove <Group Name>^r")
                print("    ^7Removes a group from a specified Player ID^r")
                print("")
                print("^2/gsperms group <Group Name> info^r")
                print("    ^7Get full permissions specifically assigned to the specified Group^r")
                print("")
                print("^2/gsperms group <Group Name> permission add <Permission Node>^r")
                print("    ^7Adds a permission node to the specified Group^r")
                print("")
                print("^2/gsperms group <Group Name> permission remove <Permission Node>^r")
                print("    ^7Removes a permission node from the specified Group^r")
                print("")
                return
            elseif #args >= 2 and args[1] == "user" then
                if GetPlayerName(args[2]) == nil then
                    print("Specified player ID it's invalid. Is the player offline?^r")
                    return
                end
                local targetID = args[2]
                local gsUser = GSPerms.GetUserById(targetID)
                if #args == 3 and args[3] == "info" then
                    print("^7User Info^r")
                    print(string.format("Name: ^2%s^r", GetPlayerName(targetID)))
                    print(string.format("IP: ^2%s^r", GetPlayerEndpoint(targetID)))
                    print(string.format("Permissions: ^2%s^r", table.concat(gsUser.getPermissions(), ", ")))
                    print(string.format("Groups: ^2%s^r", table.concat(gsUser.getGroups(), ", ")))
                    return
                end
                if #args == 5 then
                    if args[3] == "permission" then
                        local permissionNode = args[5]
                        if args[4] == "add" then
                            gsUser.addPermission(permissionNode)
                            print(
                                string.format(
                                    "^2Added^7 the permission node %s to the player with the ID %s!^r",
                                    permissionNode,
                                    targetID
                                )
                            )
                            GSPerms.SaveData(gsUser)
                            return
                        elseif args[4] == "remove" then
                            gsUser.removePermission(permissionNode)
                            print(
                                string.format(
                                    "^8Removed^7 the permission node %s from the player with the ID %s!^r",
                                    permissionNode,
                                    targetID
                                )
                            )
                            GSPerms.SaveData(gsUser)
                            return
                        end
                    elseif args[3] == "group" then
                        local groupName = args[5]
                        if args[4] == "add" then
                            gsUser.addGroup(groupName)
                            print(
                                string.format(
                                    "^2Added^7 the group %s to the player with the ID %s!^r",
                                    groupName,
                                    targetID
                                )
                            )
                            GSPerms.SaveData(gsUser)
                            return
                        elseif args[4] == "remove" then
                            gsUser.removeGroup(groupName)
                            print(
                                string.format(
                                    "^8Removed^7 the group %s from the player with the ID %s!^r",
                                    groupName,
                                    targetID
                                )
                            )
                            GSPerms.SaveData(gsUser)
                            return
                        end
                    end
                end
            elseif args[1] == "group" then
                    --
                    -- GROUP COMMANDS
                    --
                end
            print("Invalid command! Please use ^2/gsperms help^7 to see full list of commands!^r")
            return
        end
    end
)

function ChatMessage(source, message)
    TriggerClientEvent(
        "chat:addMessage",
        source,
        {
            args = {
                "GS Perms",
                message
            },
            color = {64, 230, 108}
        }
    )
end
