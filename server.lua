-- =============================================
--  Version Checker
-- =============================================
function checkUpdate(resource, repo, token)
    local current = GetResourceMetadata(resource, 'version')

    local url, headers

    if token then
        local repos = repo:gsub("https://github.com/", "")
        url = 'https://api.github.com/repos/' .. repos .. '/contents/version'
        headers = {
            ['Authorization'] = 'Bearer ' .. token,
            ['Accept']        = 'application/vnd.github+json',
            ['User-Agent']    = 'RedM-Script'
        }
    else
        local repos = repo:gsub("https://github.com/", "")
        url = 'https://raw.githubusercontent.com/' .. repos .. '/main/version'
        headers = { ['Content-Type'] = 'application/json' }
    end

    PerformHttpRequest(url, function(err, response, headers)
        if not response or response == "" then
            print("^1❕ Failed to check version file for " .. resource .. "^0")
            return
        end

        local content = response

        if token then
            local data = json.decode(response)
            if not data or not data.content then
                print("^1❕ Invalid API response for " .. resource .. "^0")
                return
            end
            content = base64Decode(data.content:gsub("\n", ""))
        end

        local latest = content:match("<%d?%d.%d?%d.?%d?%d?>")
        if latest then
            latest = latest:gsub("[<>]", "")
        else
            print("^1❕ Invalid version format in the file for " .. resource .. "^0")
            return
        end

        local update = latest > current

        if update then
            print("\n^8❌ -OUTDATED! ^6⋘ "..resource.."⋙ ^3 (Version "..current..")^0")
            print("^2New Version ^0("..latest..") ^5~"..repo.."~\n")
        else
            print("\n^2✔️ -UPDATED! ^6⋘ "..resource.."⋙ ^3 (Version "..current..")\n")
        end
    end, 'GET', '', headers)
end

AddEventHandler('onResourceStart', function(Resource)
    if Resource == GetCurrentResourceName() then
        checkUpdate(Resource, "https://github.com/imherhela/hela_watermark")
    end
end)
