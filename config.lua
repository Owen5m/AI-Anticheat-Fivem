Config = {}

-- Webhook URL for Discord logs
Config.Webhook = "https://discord.com/api/webhooks/XXXXX"

-- Admin Whitelist for skipping the anti-cheat (admins will not be banned)
Config.AdminWhitelist = {
    "steam:110000123456789", -- Admin steam ID
    "license:xxxxxxxxxxxxxx" -- Admin license ID
}

-- Detection Tolerances and Settings
Config.Tolerances = {
    MaxIdenticalMouseFrames = 3,  -- Max number of identical frames in mouse movement before triggering an alert
    MaxSilentClicks = 5,          -- Max number of clicks without movement before triggering an alert
    MaxThreadCount = 70,          -- Max number of active threads before flagging as suspicious
    MaxCpuUsage = 90,             -- Max CPU usage (%) before flagging
    MaxRamUsage = 800,            -- Max RAM usage (MB) before flagging
    MaxResourceCount = 100,       -- Max number of resources the server can handle before flagging
}

-- Ban message when player is banned
Config.BanMessage = "🚫 You have been banned for using unauthorized software."

-- If a player is flagged for suspicious activity, should they be banned immediately?
Config.AutoBan = true  -- Set to true for automatic banning upon detection

-- Specify whether to track AI behaviors and CPU/RAM usage (set to false to disable)
Config.TrackAIBehavior = true
Config.TrackCpuUsage = true
Config.TrackRamUsage = true
Config.TrackExternalProcesses = true

-- List of suspicious external processes that will lead to banning
Config.SuspiciousProcesses = {
    "cheatengine.exe",
    "redengine.exe",
    "injectedhack.dll"
}
