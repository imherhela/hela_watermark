function checkFile(resourcename, repo)
    local cleanrepo = repo:gsub("https://github.com/", "")

    local currentVersion = GetResourceMetadata(resourcename, 'version')
    PerformHttpRequest('https://raw.githubusercontent.com/'..cleanrepo..'/main/version', function(err, response, headers)
        if not response or response == "" then
            print("^1❕ Failed to check version file for " .. resourcename .. "^0")
            return
        end

        local latestVersion = response:match("<%d?%d.%d?%d.?%d?%d?>")
        if latestVersion then
            latestVersion = latestVersion:gsub("[<>]", "")
        else
            print("^1❕ Invalid version format in the file for " .. resourcename .. "^0")
            return
        end

        local updateAvailable = latestVersion > currentVersion

        if updateAvailable then
             print("\n^8❌ OUTDATED! ^6["..resourcename.."] ^3(Current Version "..currentVersion..")^0")
            print("^2New Version ^0("..latestVersion..") ^5~"..repo.."~\n")
            
        else
            print("\n^2✔️ UPDATED! ^6["..resourcename.."] ^3(Current Version "..currentVersion..")\n")
        end
    end, 'GET', '', {
        ['Content-Type'] = 'application/json'
    })
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        checkFile(resourceName, "https://github.com/imherhela/hela_watermark")
    end
end)
