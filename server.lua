local banlist = LoadResourceFile(GetCurrentResourceName(), "banlist.json") or "[]"
banlist = json.decode(banlist)

-- Function to log suspicious activity to Discord
local function logToDiscord(reason, src, extra)
    local playerName = GetPlayerName(src)
    local identifier = GetPlayerIdentifier(src, 0)

    local embed = {
        {
            ["title"] = "🚨 Suspicious Activity Detected",
            ["description"] = ("**Player:** %s\n**ID:** %s\n**Identifier:** %s\n**Reason:** %s\n**Details:** %s")
                :format(playerName, src, identifier or "unknown", reason, extra or "none"),
            ["color"] = 16711680,
            ["footer"] = {["text"] = "FiveM Anti-Cheat"}
        }
    }

    PerformHttpRequest(Config.Webhook, function() end, "POST", json.encode({ embeds = embed }), {
        ["Content-Type"] = "application/json"
    })
end

RegisterServerEvent("ac:flag")
AddEventHandler("ac:flag", function(reason, data)
    local src = source
    local id = GetPlayerIdentifier(src, 0)

    -- Skip detection for whitelisted admins
    if IsWhitelisted(id) then return end

    -- Log suspicious activity to Discord
    logToDiscord(reason, src, json.encode(data))

    -- Ban the player if AutoBan is enabled
    if Config.AutoBan then
        BanPlayer(src, reason)
    end
end)

-- Function to ban a player
function BanPlayer(src, reason)
    local id = GetPlayerIdentifier(src, 0)
    table.insert(banlist, {identifier = id, reason = reason, date = os.date()})
    SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(banlist), -1)
    DropPlayer(src, Config.BanMessage)
end

-- Check if player is whitelisted
function IsWhitelisted(identifier)
    for _, v in ipairs(Config.AdminWhitelist) do
        if identifier == v then return true end
    end
    return false
end

-- Check player when connecting
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    deferrals.defer()
    local src = source
    local id = GetPlayerIdentifier(src, 0)
    for _, b in pairs(banlist) do
        if b.identifier == id then
            deferrals.done(Config.BanMessage)
            return
        end
    end
    deferrals.done()
end)
