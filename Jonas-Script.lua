-- Lässt das Programm am laufen wenn es fertig ist --
util.keep_running()
util.require_natives(natives-1663599433-uno)

-- Auto Updater --
local status, auto_updater = pcall(require, "auto-updater")
if not status then
    local auto_update_complete = nil util.toast("Installing auto-updater...", TOAST_ALL)
    async_http.init("raw.githubusercontent.com", "/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
        function(result, headers, status_code)
            local function parse_auto_update_result(result, headers, status_code)
                local error_prefix = "Error downloading auto-updater: "
                if status_code ~= 200 then util.toast(error_prefix..status_code, TOAST_ALL) return false end
                if not result or result == "" then util.toast(error_prefix.."Found empty file.", TOAST_ALL) return false end
                filesystem.mkdir(filesystem.scripts_dir() .. "lib")
                local file = io.open(filesystem.scripts_dir() .. "lib\\auto-updater.lua", "wb")
                if file == nil then util.toast(error_prefix.."Could not open file for writing.", TOAST_ALL) return false end
                file:write(result) file:close() util.toast("Successfully installed auto-updater lib", TOAST_ALL) return true
            end
            auto_update_complete = parse_auto_update_result(result, headers, status_code)
        end, function() util.toast("Error downloading auto-updater lib. Update failed to download.", TOAST_ALL) end)
    async_http.dispatch() local i = 1 while (auto_update_complete == nil and i < 40) do util.yield(250) i = i + 1 end
    if auto_update_complete == nil then error("Error downloading auto-updater lib. HTTP Request timeout") end
    auto_updater = require("auto-updater")
end
if auto_updater == true then error("Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again") end
auto_updater.run_auto_update({source_url=auto_update_source_url, script_relpath=SCRIPT_RELPATH, verify_file_begins_with="--"})

auto_updater.run_auto_update({
    source_url="https://raw.githubusercontent.com/Jonash210801/Jonas-Script/main/Jonas-Script.lua",
    script_relpath="SCRIPT_RELPATH",
    verify_file_begins_with="--"
})

-- Menu Lists --

local PlayerList = menu.list(menu.my_root(), "Player", {}, "Player Options") 
local VehicleList = menu.list(menu.my_root(), "Vehicle", {}, "Vehicle Options")

-- PlayerList Options --

menu.action(PlayerList, "Knopf 1.0", {}, "Test", function()
    util.toast("Knopf 1.0 gedrückt")
end)

tpf_units = 2
menu.action(Sprite.new("RadialMenuDemo", "Teleport"), function()
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, tpf_units, 0)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    util.toast("You tped forward")
)
-- VehicleList Options --

menu.action(VehicleList, "Knopf 2.0", {}, "Test", function()
    util.toast("Knopf 2.0 gedrückt")
end)
