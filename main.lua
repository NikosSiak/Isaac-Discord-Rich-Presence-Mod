require 'discordIPC'
require 'idToDiscordAsset'

local DiscordAdvanceRichPresence = RegisterMod("Discord Advance Rich Presence", 1)

local CLIENT_ID = ''
local time = -1
local state = ''

local function CreateActivity()
    local player = Isaac.GetPlayer(0)
    local level = Game():GetLevel()

    local activity = {
        state = state,
        details = 'C: ' .. player:GetNumCoins() .. ', B: ' .. player:GetNumBombs() .. ', K: ' .. player:GetNumKeys(),
        assets = {
            large_text = level:GetName(),
            large_image = StageToDiscordAsset(level:GetStage(), level:GetStageType()),
            small_text = 'Playing as ' .. player:GetName(),
            small_image = CharacterToDiscordAsset(player:GetPlayerType())
        },
        timestamps = {
            start = time
        }
    }

    return activity
end

function DiscordAdvanceRichPresence:ConnectToDiscord(_)
    Connect(CLIENT_ID)

    time = os.time()

    UpdateActivity(CreateActivity())

    state = 'Seed: ' .. Game():GetSeeds():GetStartSeedString()
end

function DiscordAdvanceRichPresence:UpdatePresence(_)
    UpdateActivity(CreateActivity())
end

function DiscordAdvanceRichPresence:ClosePresence(_)
    Disconnect()
end

DiscordAdvanceRichPresence:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DiscordAdvanceRichPresence.ConnectToDiscord)
DiscordAdvanceRichPresence:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DiscordAdvanceRichPresence.UpdatePresence)
DiscordAdvanceRichPresence:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, DiscordAdvanceRichPresence.ClosePresence)
