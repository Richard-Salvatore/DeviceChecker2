

local endpoint = "https://httpbin.org/user-agent"
local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/Richard-Salvatore/DeviceCheckerAPI2/refs/heads/main/Salvatore.lua", true))()

local http = game:GetService("HttpService")

local req = request or (fluxus and fluxus.request)

local function find()
    local res = req({
        Url = endpoint,
        Method = "GET"
    })

    return res.Body
end

local function parse(res)
    local agent = http:JSONDecode(res)

    if (agent) and (agent["user-agent"]) then
        return agent["user-agent"]
    else
        api.warn("Invalid user-agent information.")
        
        return nil
    end
end

local function platform(agent)
    if (string.find(agent, "Android")) then
        return "Android"
    elseif (string.find(agent, "iOS")) then
        return "iOS"
    elseif (string.find(agent, "Windows") or string.find(agent, "Krampus") or string.find(identifyexecutor(), "Wave") or
            string.find(agent, "Swift") or string.find(agent, "Xeno") or string.find(agent, "Seline") or
            string.find(agent, "Atlantis") or string.find(agent, "Zorara") or string.find(agent, "Luna") or
            string.find(agent, "JJSploit")) then
        return "Windows"
    else
        api.log(agent)
    end
end



local function main()
    local agent = find()

    if (agent) then
        local platform = parse(agent)
    
        if (platform) then
            api.log("Connected with " .. platform)
            return platform
        else
            api.warn("Failed to determine platform from user-agent. Defaulting to Mobile.")
            return "Android"
        end
    else
        api.warn("Failed to fetch user-agent information. Defaulting to Mobile.")
        return "Android"
    end
end

return main()
