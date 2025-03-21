function checkUpdate(resource, repo)
    local repos = repo:gsub("https://github.com/", "")

    local current = GetResourceMetadata(resource, 'version')
    PerformHttpRequest('https://raw.githubusercontent.com/'..repos..'/main/version', function(err, response, headers)
        if not response or response == "" then
            print("^1❕ Failed to check version file for " .. resource .. "^0")
            return
        end

        local latest = response:match("<%d?%d.%d?%d.?%d?%d?>")
        if latest then
            latest = latest:gsub("[<>]", "")
        else
            print("^1❕ Invalid version format in the file for " .. resource .. "^0")
            return
        end

        local update = latest > current

        if update then
            print("\n^8❌ -OUTDATED! ^6⋘ "..resource.."⋙ ^3(Version "..current..")^0")
            print("^2New Version ^0("..latest..") ^5~"..repo.."~\n")
            
        else
            print("\n^2✔️ -UPDATED! ^6⋘ "..resource.."⋙ ^3 (Version "..current..")\n")
        end
    end, 'GET', '', {
        ['Content-Type'] = 'application/json'
    })
end

AddEventHandler('onResourceStart', function(Resource)
    if Resource == GetCurrentResourceName() then
        -- Replace with your actual GitHub repository link
        -- checkRelease(resourceName, "https://github.com/imherhela/hela_watermark")
        -- OR if using a version file
        checkUpdate(Resource, "https://github.com/imherhela/hela_watermark")
    end
end)
--[[
    ^0 = white
    ^1 = pinkish red
    ^2 = green
    ^3 = yellow
    ^4 = periwinkle
    ^5 = sky blue
    ^6 = purple
    ^7 = white greyish
    ^8 = red
    ^9 = blue
]]
