Settings = {
    ["SlotWaitTime"] = 0.19; -- Time it takes between the last two chats | 0.15 works w/o a vpn (differs per person)
    ["KamiWaitTime"] = 0.19; -- Time it takes to talk to kami after slot switch | 0.15 works w/o a vpn (differs per person)
    ["HideName"] = "Youtube Pumpkhn"; -- "none/None" to disable
    ["StopAfter"] = 0; -- 0 to disable
}
Accounts = {
    ["VerifiedBuckzYT"] = { -- PUT YOUR MAIN ACCOUNT'S FULL USERNAME IN HERE.
        ["Main"] = 1; -- MAIN SLOT
        ["Namek"] = 2 -- NAMEKIAN SLOT
    };
    ["Aloof"] = {
        ["Main"] = 2;
        ["Namek"] = 1;
    };
} -- IF YOU WISH TO ADD MORE ACCOUNTS JUST COPY PASTE

Debug = false;


--[[
keep in mind, this source was never supposed to be given out lmao
created by aloof because I never gave myself credit
]]-- 

repeat
    task.wait()
until game:IsLoaded()
repeat
    task.wait()
until game.Players.LocalPlayer.Character
function getVars()
    plr = game.Players.LocalPlayer
    char = plr.Character
    hrp = char:WaitForChild("HumanoidRootPart")
    bp = plr:WaitForChild("Backpack")
    st = bp:FindFirstChild("ServerTraits")
end
getVars()
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    getVars()
end)
function notif(Title1,Message1) -- my old cmd notify func cus I can't remember how to make it
    game:GetService("StarterGui"):SetCore(
        "SendNotification",
        {
            Title = Title1,
            Text = Message1,
        }
    )
end
function getAcc()
    if game.PlaceId == 552500546 then return end
    for i,v in pairs(Accounts) do
        if i:lower() == (plr.Name):lower() then
            return v["Main"], v["Namek"]
        end
    end
    return false
end
if getAcc() == false then
    notif("Inf stat","Account not found")
    return
end
local MainSlot, NamekSlot = getAcc()
function stop()
    if Settings["StopAfter"] == 0 then return end
    local tL = plr.PlayerGui.HUD.Bottom.Stats.StatPoints.Val
    if tonumber(tL.Text) >= Settings["StopAfter"] then
        return false
    end
end

function getKami()
    for i,v in pairs(game:GetDescendants()) do
        if v.Name == "KAMI" then
            if v.Parent.Name == "Hidden" or v.Parent.Name == "FriendlyNPCs" then
                return v
            end
        end
    end
end
function anti_afk()
    plr.Idled:Connect(function()
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end
anti_afk()
function getLvl()
    for i,v in pairs(char:GetChildren()) do
        if v.Name:find("Lvl.") and v.Name:match("Lvl.%s(%d+)") then
            return tonumber(v.Name:match('Lvl.%s(%d+)'))
        end
    end
    return false
end -- overcomplicated func. just fucking with string patterns
function debugPrt(arg)
    if Debug then
        print(arg)
        return
    end
    return false
end
function reJoin()
    plr:Kick("Rejoining, don't leave like Nebi did")
    task.wait(0.2)
    game:GetService("TeleportService"):Teleport(game.PlaceId,plr)
end
function load()
    debugPrt("Load Starting")
    if game.PlaceId == 552500546 then return end
    repeat task.wait(); debugPrt("Waiting for Char") until char
    char:WaitForChild("PowerOutput",5)
    debugPrt(char:FindFirstChild("PowerOutput"))
    if not char:FindFirstChild("PowerOutput") then
        debugPrt("P/O not found")
        reJoin()
        return
    end
    local tim = os.time()
    repeat task.wait() until (getLvl() ~= false) or (os.time()-tim) > 5
    if os.time()-tim > 5 then
        reJoin()
        return
    end
    debugPrt("getLvl() was true")
    return true
end
load()
debugPrt("Initial load function completed")
function getSlot()
    if char:FindFirstChild("Head") and char:FindFirstChild("Race") then
        local race = char:FindFirstChild("Race")
        if race.Value == "Namekian" then
            if getLvl() <= 100 then
                return "Namek"
            end
        end
    end
    return "Main"
end
function findQuestGiver(questChat)
    for i,v in pairs(game.Workspace.FriendlyNPCs:GetDescendants()) do
        if v.Name == "Chat" and v:IsA("StringValue") and v.Value == questChat then
            return v
        end
    end
end
function cAd(chat)
        st.ChatAdvance:FireServer({tostring(chat)})
    task.wait(0.6)
end
function lvlUp()
    if getSlot() == "Namek" then
        if getLvl() < 50 then
            local fNPC = game.Workspace.FriendlyNPCs
            st.ChatStart:FireServer(fNPC.Bulma.Chat)
            task.wait(0.4)
            cAd("k")
            cAd("Yes")
            cAd("k")
            st.ChatStart:FireServer(fNPC:FindFirstChild("SpaceShip"))
            task.wait(0.4)
            cAd("No")
            cAd("k")
            st.ChatStart:FireServer(findQuestGiver("I heard there's a spaceship in Yunzabit Heights").Parent)
            task.wait(0.4)
            cAd("k")
            cAd("Yes")
            cAd("k")
            st.ChatStart:FireServer(fNPC.NamekianShip)
            task.wait(0.4)
            cAd("No")
            cAd("k")
            st.ChatStart:FireServer(fNPC["Trunks [Future]"])
            task.wait(0.4)
            cAd("k")
            cAd("Yes")
            cAd("k")
            st.ChatStart:FireServer(fNPC.TimeMachine)
            task.wait(0.4)
            cAd("No")
            cAd("k")
            st.ChatStart:FireServer(fNPC["Elder Kai"])
            task.wait(0.4)
            cAd("k")
            cAd("Yes")
            cAd("k")
            cAd("k")
            st.ChatStart:FireServer(fNPC["Korin"].Chat.Chat)
            task.wait(0.4)
            st.ChatAdvance:FireServer({"k"})
            task.wait(0.4)
            st.ChatAdvance:FireServer({"k"})
            task.wait(0.4)
            st.ChatAdvance:FireServer({"DRINK"})
            task.wait(0.4)
            st.ChatAdvance:FireServer({"k"})
        end
    end
end
function resetChar()
    if game.placeId == 552500546 then
        repeat
            task.wait()
        until plr.Backpack:FindFirstChild("Scripter"):FindFirstChild("Setup"):FindFirstChild("Frame"):FindFirstChild("Side").Visible == true
        task.wait(4)
        bp.Scripter.RemoteEvent:FireServer(bp.Scripter.Setup.Frame.Side.Race,"up")
        task.wait(1)
        bp.Scripter.RemoteEvent:FireServer("woah")
        task.wait(1)
        game:Shutdown()
    else
        st.ChatStart:FireServer(game.Workspace.FriendlyNPCs["Start New Game [Redo Character]"])
        task.wait(0.4)
        st.ChatAdvance:FireServer({"Yes"})
        task.wait(0.4)
        st.ChatAdvance:FireServer({"k"})
        task.wait(0.4)
        st.ChatAdvance:FireServer({"Yes"})
        task.wait(1)
        game:GetService("TeleportService"):Teleport(552500546)
    end
end
function getName()
    if Settings["HideName"]:lower() ~= ("None"):lower() then
        return Settings["HideName"]
    else
        return plr.Name
    end
end
debugPrt("Functions loaded correctly")
success = false
resetSlot = false
notif("Inf Stat","Public Version V4")
function doTheInf()
debugPrt("doTheInf function started")
local timeToWait = 2

    if stop() == false then
        return
    end

    if game.PlaceId == 552500546 then
        resetChar()
        return
    end;
    success = false
    if game.GameId ~= 210213771 then -- not in fs nigger!
        return
    end

    if game.PlaceId ~= 536102540 then
        -- teleport or say fuck it
        return;
    end
    repeat task.wait() until getSlot() ~= nil
    debugPrt("Passed initial functions in doTheInf function")
    if getSlot() == "Namek" then
        debugPrt("Namekian slot found")
        if getLvl() < 50 then
            debugPrt("Namekian is lvl < 50, leveling up the slot")
            local time = os.time()
            repeat
                lvlUp() -- levels up if you're below level 50
                task.wait(5)
            until ((os.time()-time) >= 60) or (getLvl() >= 50)
            task.wait(3)
            if(os.time()-time >= 60 and getLvl() < 50) then -- failed!
                reJoin()
                return
            elseif getLvl() >= 50 then
                doTheInf()
            end
        end;
        if getLvl() >= 50 then
            debugPrt("Lvl >= 50")
            if (getKami() == false) or (resetSlot == true)  then
                debugPrt("Kami not found")
                if getLvl() > 100 then return end
                notif("Test","shit is NOT WORKING....... resetting slot :(")
                task.wait(5)
                resetChar() -- if kami is bugged, resets the character, restarting the cycle
                return
            end
            local chatStart = st.ChatStart
            local chatAdv  = st.ChatAdvance
            local textLabel = plr.PlayerGui:WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui").TextLabel
            local time = os.time()
            local done = false
            local chatted_with_kami = false
            resetSlot = false
            repeat task.wait(); chatStart:FireServer(game.Workspace.FriendlyNPCs:FindFirstChild("Character Slot Changer")); until textLabel.text == "Change Character Slots?" or (os.time()-time) >= timeToWait
            repeat task.wait(); chatAdv:FireServer({"Yes"}) until textLabel.text == "Alright" or (os.time()-time) >= timeToWait
            repeat task.wait(); chatAdv:FireServer({"k"}) until textLabel.text == "Which slot would you like to play in?" or (os.time()-time) >= timeToWait
            task.wait(0.1)
            if textLabel.text ~= "Which slot would you like to play in?" then
                doTheInf()
                return
            end
            task.wait(Settings["SlotWaitTime"])
            chatAdv:FireServer({"Slot"..tostring(MainSlot)})
            task.wait(Settings["KamiWaitTime"])
            if textLabel.text ~= "Loading!" then
                debugPrt("Redoing")
                doTheInf()
                return
            end
            local kami = getKami()
            local kamiChat = function()
                st.ChatStart:FireServer(kami.Chat)
                st.ChatAdvance:FireServer({"k"})      
            end
            repeat task.wait(); kamiChat() until textLabel.Text == "Mr Popo is a nice guy" or textLabel.Text == "Alright let's do it" or not plr.PlayerGui:FindFirstChild("HUD")
            if textLabel.Text == "Mr Popo is a nice guy" then
                resetSlot = true
                notif("Inf stat","Reset slot yay")
            elseif textLabel.Text == "Alright let's do it" then
                task.wait(0.3)
                if not hrp:FindFirstChild("Booster") then
                    reJoin()
                    return
                end
            end
            task.wait(0.8)
            if plr.PlayerGui:FindFirstChild("HUD") then
                if hrp:FindFirstChild("Booster") then
                    resetSlot = true
                    task.wait(3)
                    resetChar()
                end
            elseif not plr.PlayerGui:FindFirstChild("HUD") then
                chatted_with_kami = true
            end
            debugPrt("Namekian side completed")
        end
    elseif getSlot() == "Main" then
        debugPrt("Main Started")
        local chatStart = st.ChatStart
        local chatAdv  = st.ChatAdvance
        local textLabel = plr.PlayerGui:WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui"):WaitForChild("TextLabel")
        local done = false  
        local fucked_up_main_slot_change = false
        local time = os.time()
        repeat chatStart:FireServer(game.Workspace.FriendlyNPCs:FindFirstChild("Character Slot Changer")); task.wait();  until textLabel.text == "Change Character Slots?" or (os.time()-time) >= timeToWait
        repeat chatAdv:FireServer({"Yes"}); task.wait(); plr.PlayerGui.HUD.Bottom.ChatGui.Visible = true until textLabel.text == "Alright" or (os.time()-time) >= timeToWait
        repeat chatAdv:FireServer({"k"}); task.wait(); until textLabel.text == "Which slot would you like to play in?" or (os.time()-time) >= timeToWait
        repeat chatAdv:FireServer({"Slot"..tostring(NamekSlot)}); task.wait(0.15); until textLabel.text == "Loading!" or (os.time()-time) >= timeToWait
        task.wait(0.9)
        if plr.PlayerGui:FindFirstChild("HUD") then
            doTheInf()
            return
        end
        task.wait(0.5)
        if not plr.PlayerGui:FindFirstChild("HUD") then done = true end
    end
    success = true
end

plr.CharacterAdded:Connect(function()
    local t = tick()
    load()
    plr.PlayerGui.HUD.Bottom.Stats.Labvel.TextLabel.Text = "Youtube Pumpkhn"
    plr.PlayerGui.HUD.Bottom.Stats.Namae.Val.Text = getName()
    plr.PlayerGui.HUD.Bottom.Stats.Visible = true
    doTheInf()
end)
doTheInf()