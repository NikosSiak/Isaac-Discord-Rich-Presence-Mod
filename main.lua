require 'discordIPC'
require 'idToDiscordAsset'
require 'challenges'
require 'difficulty'

local DiscordAdvanceRichPresence = RegisterMod("Discord Advance Rich Presence", 1)

local CLIENT_ID = ''
local time = -1
local state = ''

local function GetDetails()
    local game = Game()
    if game.Challenge ~= 0 then
        return 'In ' .. GetChallengeName(game.Challenge) .. ' challenge'
    end

    return 'In ' .. GetDifficultyName(game.Difficulty) .. ' mode'
end

local function CreateActivity()
    local player = Isaac.GetPlayer(0)
    local level = Game():GetLevel()

    local activity = {
        state = state,
        details = GetDetails(),
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
