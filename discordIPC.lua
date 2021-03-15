require 'utf8_utils'
local json = require 'json'
local struct = require 'struct'

local OP_HANDSHAKE = 0
local OP_FRAME = 1
local OP_CLOSE = 2

local sock = nil

local function send(opcode, payload)
    local function encode(opcode, payload)
        payload = json.encode(payload)
        payload = payload:toutf8() 
        return struct.pack('<ii', opcode, #payload) .. payload
    end

    local encodedPayload = encode(opcode, payload)
    sock:write(encodedPayload)
    sock:flush()
end

function Connect(clientID)
    sock = io.open('\\\\?\\pipe\\discord-ipc-0', "w+b")
    send(OP_HANDSHAKE, {v = 1, client_id = clientID})
end

function Disconnect()
    if sock ~= nil then
        send(OP_CLOSE, {})
        sock:close()
        sock = nil
    end
end

function UpdateActivity(activity)
    if sock ~= nil then
        local payload = {
            cmd = 'SET_ACTIVITY',
            args = {
                activity = activity,
                pid = 1312
            },
            nonce = '1312'
        }
        send(OP_FRAME, payload)
    end
end