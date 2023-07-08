local screen = GetPartFromPort(4, "TouchScreen")
local screen2 = GetPartFromPort(1, "TouchScreen")
local modem = GetPartFromPort(1, "Modem")
local keyboard = GetPartFromPort(1, "Keyboard")
local speaker = GetPartFromPort(1, "Speaker")
local mic = GetPartFromPort(1, "Microphone")
local gyro = GetPartFromPort(1, "Gyro")
local gyroswitch = GetPartFromPort(1, "Switch")
local ion = GetPartFromPort(1, "IonRocket")
local ionswitch = GetPartFromPort(7, "Switch")
local polysilicon = GetPartFromPort(3, "Polysilicon")
local controlmode = false
local luarunner = GetPartFromPort(2, "Microcontroller")
local storage = GetPartFromPort(8, "Disk")
local anchor = GetPartFromPort(1, "Anchor")
local mode
local keyboardlog = {}
local miclog = {}
local canacceptnetworkcommands
local setupcomplete
local function Splice(string1, string2, string3)
	local output = string1 .. string2 .. string3
	return output
end
if screen ~= nil and storage ~= nil then
	screen:ClearElements()
	canacceptnetworkcommands = storage:Read("NetworkCommands")
	setupcomplete = storage:Read("SetupState")
	if setupcomplete == true then
		local whitelist = {}
		local whitelistenabled = storage:Read("WhitelistEnabled")
		if whitelistenabled == true then
			local rawlist = storage:Read("Whitelist")
			local whitelistprogress = 1
			for i = 1, #rawlist, 1 do
				if string.sub(rawlist, i, i) == "," or i == #rawlist then
					local cutoff = 1
					if i == #rawlist then
						cutoff = 0
					end
					whitelist[string.sub(rawlist, whitelistprogress, i - cutoff)] = true
					whitelistprogress = i + 1
				end
			end
		end
		local background = screen:CreateElement("ImageLabel", {
			Size = UDim2.fromOffset(450, 450);
			Image = "http://www.roblox.com/asset/?id=1369437447";
		})
		local shutdown = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(15, 15);
			Size = UDim2.fromOffset(100, 100);
			Text = "Shutdown";
			TextScaled = true;
		})
		shutdown.MouseButton1Click:Connect(function()
			if controlmode == false then
				if screen2 ~= nil then
					screen2:ClearElements()
				end
				screen:ClearElements()
				TriggerPort(6)
			end
		end)
		local restart = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(130, 15);
			Size = UDim2.fromOffset(100, 100);
			Text = "Restart";
			TextScaled = true;
		})
		restart.MouseButton1Click:Connect(function()
			if controlmode == false then
				if screen2 ~= nil then
					screen2:ClearElements()
				end
				screen:ClearElements()
				TriggerPort(5)
			end
		end)
		local function RunControlMode()
			if controlmode ~= true then
				local titlebar = screen:CreateElement("TextLabel", {
					Size = UDim2.fromOffset(425, 25);
					Text = "Control Mode";
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
					TextScaled = true;
					ZIndex = 2;
				})
				local closebutton = screen:CreateElement("TextButton", {
					Text = "X";
					Size = UDim2.fromOffset(25, 25);
					Position = UDim2.fromOffset(425, 0);
					BorderSizePixel = 0;
					BackgroundColor3 = Color3.fromRGB(255,0,0);
					TextScaled = true;
					ZIndex = 2;
				})
				local frame = screen:CreateElement("Frame", {
					Position = UDim2.fromOffset(0, 25);
					Size = UDim2.fromOffset(450, 425);
					BorderSizePixel = 0;
					ZIndex = 2;
					Active = true;
				})
				local runcurcode = screen:CreateElement("TextButton", {
					Text = "Run current code";
					TextScaled = true;
					Position = UDim2.fromOffset(15, 15);
					Size = UDim2.fromOffset(120, 40);
					BackgroundColor3 = Color3.fromRGB(0,255,0);
				})
				local stopruncode = screen:CreateElement("TextButton", {
					Text = "Stop running code";
					TextScaled = true;
					Size = UDim2.fromOffset(120, 40);
					Position = UDim2.fromOffset(150, 15);
					BackgroundColor3 = Color3.fromRGB(255,0,0)
				})
				local inputhistory = screen:CreateElement("Frame", {
					Size = UDim2.fromOffset(450, 250);
					Position = UDim2.fromOffset(0, 175);
				})
				local inputtextlabel = screen:CreateElement("TextLabel", {
					Text = "Input History";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					Size = UDim2.fromOffset(450, 25);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0
				})
				local modetext = screen:CreateElement("TextLabel", {
					Text = "Mode";
					Size = UDim2.fromOffset(450, 25);
					Position = UDim2.fromOffset(0, 25);
					TextColor3 = Color3.fromRGB(255,255,255);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0;
					TextScaled = true;
				})
				local modemic = screen:CreateElement("TextButton", {
					Text = "Microphone";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					Size = UDim2.fromOffset(225, 25);
					Position = UDim2.fromOffset(0, 50);
					BorderSizePixel = 0;
				})
				local modekeyboard = screen:CreateElement("TextButton", {
					Text = "Keyboard";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					Size = UDim2.fromOffset(225, 25);
					Position = UDim2.fromOffset(225, 50);
					BorderSizePixel = 0;
				})
				local inputlog = screen:CreateElement("ScrollingFrame", {
					Size = UDim2.fromOffset(450, 175);
					Position = UDim2.fromOffset(0, 75);
					ScrollBarThickness = 6;
				})
				titlebar:AddChild(closebutton)
				titlebar:AddChild(frame)
				frame:AddChild(runcurcode)
				frame:AddChild(stopruncode)
				frame:AddChild(inputhistory)
				inputhistory:AddChild(inputtextlabel)
				inputhistory:AddChild(modetext)
				inputhistory:AddChild(modemic)
				inputhistory:AddChild(modekeyboard)
				inputhistory:AddChild(inputlog)
				controlmode = true
				runcurcode.MouseButton1Click:Connect(function()
					if polysilicon ~= nil and luarunner ~= nil then
						polysilicon:Configure({PolysiliconMode = 0})
						TriggerPort(3)
					end
				end)
				stopruncode.MouseButton1Click:Connect(function()
					if luarunner ~= nil and polysilicon ~= nil then
						if screen2 ~= nil then
							screen2:ClearElements()
						end
						polysilicon:Configure({PolysiliconMode = 1})
						TriggerPort(3)
					end
				end)
				inputlog = screen:CreateElement("ScrollingFrame", {
					Size = UDim2.fromOffset(450, 175);
					Position = UDim2.fromOffset(0, 75);
					ScrollBarThickness = 6;
				})
				inputhistory:AddChild(inputlog)
				for i, message in pairs(miclog) do
					local textlabel = screen:CreateElement("TextLabel", {
						Text = message;
						TextScaled = true;
						Size = UDim2.fromOffset(444, 25);
						Position = UDim2.fromOffset(0, (i - 1) * 25);
					})
					inputlog:ChangeProperties({CanvasSize = UDim2.fromOffset(0, i * 25)})
					inputlog:AddChild(textlabel)
				end
				modekeyboard.MouseButton1Click:Connect(function()
					mode = "Keyboard"
					inputlog:Destroy()
					inputlog = screen:CreateElement("ScrollingFrame", {
						Size = UDim2.fromOffset(450, 175);
						Position = UDim2.fromOffset(0, 75);
						ScrollBarThickness = 6;
					})
					inputhistory:AddChild(inputlog)
					for i, message in pairs(keyboardlog) do
						local textlabel = screen:CreateElement("TextLabel", {
							Text = message;
							TextScaled = true;
							Size = UDim2.fromOffset(444, 25);
							Position = UDim2.fromOffset(0, (i - 1) * 25);
						})
						inputlog:ChangeProperties({CanvasSize = UDim2.fromOffset(0, i * 25)})
						inputlog:AddChild(textlabel)
					end
				end)
				modemic.MouseButton1Click:Connect(function()
					mode = "Microphone"
					inputlog:Destroy()
					inputlog = screen:CreateElement("ScrollingFrame", {
						Size = UDim2.fromOffset(450, 175);
						Position = UDim2.fromOffset(0, 75);
						ScrollBarThickness = 6;
					})
					inputhistory:AddChild(inputlog)
					for i, message in pairs(miclog) do
						local textlabel = screen:CreateElement("TextLabel", {
							Text = message;
							TextScaled = true;
							Size = UDim2.fromOffset(444, 25);
							Position = UDim2.fromOffset(0, (i - 1) * 25);
						})
						inputlog:ChangeProperties({CanvasSize = UDim2.fromOffset(0, i * 25)})
						inputlog:AddChild(textlabel)
					end
				end)
				closebutton.MouseButton1Click:Connect(function()
					controlmode = false
					titlebar:Destroy()
				end)
			end
		end
		local ctrlmodebtn = screen:CreateElement("TextButton", {
			Size = UDim2.fromOffset(100, 100);
			Position = UDim2.fromOffset(245, 15);
			Text = "Control Mode";
			TextScaled = true;
			TextWrapped = true;
		})
		ctrlmodebtn.MouseButton1Click:Connect(function()
			RunControlMode()
		end)
		local function luarun(codetorun)
			if luarunner ~= nil and polysilicon ~= nil then
				luarunner:Configure({Code = codetorun})
				polysilicon:Configure({PolysiliconMode = 0})
				wait(0.5)
				TriggerPort(3)
				print(codetorun)
			end
		end
		local function luastop()
			if luarunner ~= nil and polysilicon ~= nil then
				if screen2 ~= nil then
					screen2:ClearElements()
				end
				polysilicon:Configure({PolysiliconMode = 1})
				TriggerPort(3)
			end
		end
		local function check(command, plr)
			local canruncheck = false
			if whitelist[plr] == true or whitelistenabled == false then
				canruncheck = true
			end
			if canruncheck == true and controlmode == true then
				if string.sub(command, 1, 6) == "follow" and command ~= "followme" then
					if gyro ~= nil and gyroswitch ~= nil then
						local persontofollow = string.sub(command, 8, #command)
						gyro:Configure({Seek = persontofollow})
						gyroswitch:Configure({SwitchValue = true})
					end
				elseif command == "followme" then
					if gyro ~= nil and gyroswitch ~= nil and plr ~= nil then
						gyro:Configure({Seek = plr})
						gyroswitch:Configure({SwitchValue = true})
					end
				elseif command == "stop following" then
					if gyro ~= nil and gyroswitch ~= nil then
						gyro:Configure({Seek = ""})
						gyroswitch:Configure({SwitchValue = false})
					end
				elseif command == "move" then
					if ionswitch ~= nil then
						ionswitch:Configure({SwitchValue = true})
					end
				elseif command == "stop moving" then
					if ionswitch ~= nil then
						ionswitch:Configure({SwitchValue = false})
					end
				elseif string.sub(command, 1, 10) == "play audio" then
					if speaker ~= nil then
						local audio = string.sub(command, 12, #command)
						speaker:Configure({Audio = audio})
						speaker:Trigger()
					end
				elseif string.sub(command, 1, 9) == "set pitch" then
					local pitch = string.sub(command, 11, #command)
					speaker:Configure({Pitch = pitch})
					speaker:Trigger()
				elseif string.sub(command, 1, 3) == "say" then
					if speaker ~= nil then
						speaker:Chat(string.sub(command, 5, #command))
					end
				elseif string.sub(command, 1, 9) == "set speed" then
					if ion ~= nil then
						local propulsion = string.sub(command, 11, #command)
						ion:Configure({Propulsion = propulsion})
					end
				elseif string.sub(command, 1, 7) == "lua run" then
					luastop()
					luarun(string.sub(command, 9, #command))
				elseif command == "lua stop" then
					luastop()
				elseif command == "stop" then
					if ionswitch ~= nil then
						ionswitch:Configure({SwitchValue = false})
					end
					if gyro ~= nil and gyroswitch ~= nil then
						gyro:Configure({Seek = ""})
						gyroswitch:Configure({SwitchValue = false})
					end	
				elseif command == "anchor" then
					if anchor ~= nil then
						anchor:Configure({Anchored = true})
					end
				elseif command == "unanchor" then
					if anchor ~= nil then
						anchor:Configure({Anchored = false})
					end
				elseif command == "enable network commanding" then
					storage:Write("NetworkCommands", true)
					canacceptnetworkcommands = true
				elseif command == "disable network commanding" then
					storage:Write("NetworkCommands", false)
					canacceptnetworkcommands = false
				elseif string.sub(command, 1, 9) == "whitelist" then
					local playertowhitelist = string.sub(command, 11, #command)
					local foundinvalidchar = false
					for i = 1, #playertowhitelist, 1 do
						if string.sub(playertowhitelist, i, i) == "," then
							foundinvalidchar = true
						end
					end
					if foundinvalidchar == false then
						local rawlist = storage:Read("Whitelist")
						local playerwhitelisted = false
						for i = 1, #rawlist, 1 do
							if string.sub(rawlist, i, #rawlist + i - 1) == playertowhitelist then
								playerwhitelisted = true
							end
						end
						if playerwhitelisted == false then
							whitelist[playertowhitelist] = true
							local newrawlist = Splice(rawlist, ",", playertowhitelist)
							storage:Write("Whitelist", newrawlist)
						else
							speaker:Chat("Player already whitelisted.")
						end
					else
						speaker:Chat("Invalid character detected.")
					end
				elseif string.sub(command, 1, 11) == "unwhitelist" then
					local playertounwhitelist = string.sub(command, 13, #command)
					local foundplayer = false
					if playertounwhitelist ~= plr then
						local implemented = true
						if implemented == true then
							whitelist[playertounwhitelist] = false
							local rawlist = storage:Read("Whitelist")
							for i = 1, #rawlist, 1 do
								if string.sub(rawlist, #playertounwhitelist + i - 1) == playertounwhitelist then
									foundplayer = true
									if string.sub(rawlist, i - 1, i - 1) == "," then
										speaker:Chat("h")
										local newrawlist1 = string.sub(rawlist, 1, i - 2)
										local newrawlist2 = string.sub(rawlist, #playertounwhitelist + i)
										local newrawlist = newrawlist1 .. newrawlist2
										storage:Write("Whitelist", newrawlist)
									elseif string.sub(rawlist, playertounwhitelist + i, playertounwhitelist + i) == "," then
										local newrawlist1 = string.sub(rawlist, 1, i - 1)
										local newrawlist2 = string.sub(rawlist, #playertounwhitelist + i + 1)
										local newrawlist = newrawlist1 .. newrawlist2
										storage:Write("Whitelist", newrawlist)
									end
								end
							end
							if foundplayer == false then
								speaker:Chat("Player not found.")
							end
						else
							speaker:Chat("Function not implemented.")
						end
					else
						speaker:Chat("You can't unwhitelist yourself.")
					end
				elseif command == "reset" then
					storage:ClearDisk()
				elseif command == "show the current whitelist" then
					local curwhitelist = storage:Read("Whitelist")
					speaker:Chat(curwhitelist)
				end
			end
		end
		if mic ~= nil then
			mic:Connect("Chatted", function(plr, txt)
				if string.sub(txt, 1, 6) == "drone," then
					local command = string.sub(txt, 8, #txt)
					check(command, plr)
				elseif string.sub(txt, 1, 7) == "goober," then
					local command = string.sub(txt, 9, #txt)
					check(command, plr)				
				end
				local loggedmsg = "[" .. plr .. "]: " .. txt
				if #miclog == 400 or #miclog >= 400 then
					for i, message in pairs(miclog) do
						if i == 1 then
							miclog[i] = nil
						else
							miclog[i - 1] = message
						end
					end
					miclog[400] = loggedmsg
				else
					miclog[#miclog + 1] = loggedmsg
				end
			end)
		end
		if keyboard ~= nil then
			keyboard:Connect("TextInputted", function(txt, plr)
				local command = string.sub(txt, 1, #txt - 1)
				check(command, plr)
				local loggedmsg = "[" .. plr .. "]: " .. command
				if #keyboardlog == 400 or #keyboardlog >= 400 then
					for i, message in pairs(keyboardlog) do
						if i == 1 then
							keyboardlog[i] = nil
						else
							keyboardlog[i - 1] = message
						end
					end
					keyboardlog[400] = loggedmsg
				else
					keyboardlog[#keyboardlog + 1] = loggedmsg
				end
			end)
		end
		if modem ~= nil then
			modem:Connect("MessageSent", function(MsgSent)
				if canacceptnetworkcommands == true and string.sub(MsgSent, 1, 4) == "%%01" then
					check(string.sub(MsgSent, 6, #MsgSent))
				end
			end)
		end
	else
		local whiteliststatus = false
		local setup = screen:CreateElement("TextLabel", {
			Text = "Setup";
			TextScaled = true;
			Size = UDim2.fromOffset(450, 25);
			BackgroundColor3 = Color3.fromRGB(0,0,0);
			TextColor3 = Color3.fromRGB(255,255,255);
			BorderSizePixel = 0;
		})
		local main_frame = screen:CreateElement("Frame", {
			Size = UDim2.fromOffset(450, 425);
			Position = UDim2.fromOffset(0, 25);
			BackgroundColor3 = Color3.fromRGB(60, 110, 210);
			BorderSizePixel = 0;
		})
		local whitelistlabel = screen:CreateElement("TextLabel", {
			Text = "Whitelist:";
			TextScaled = true;
			TextColor3 = Color3.fromRGB(255,255,255);
			BackgroundTransparency = 1;
			Size = UDim2.fromOffset(60, 25);
			Position = UDim2.fromOffset(10, 35);
		})
		local whitelisttoggle = screen:CreateElement("TextButton", {
			BackgroundColor3 = Color3.fromRGB(255,0,0);
			Text = "OFF";
			Size = UDim2.fromOffset(50, 25);
			Position = UDim2.fromOffset(80, 35);
		})
		local nextbutton = screen:CreateElement("TextButton", {
			Size = UDim2.fromOffset(120, 40);
			Position = UDim2.fromOffset(320, 400);
			Text = "Next";
			TextScaled = true;
			TextColor3 = Color3.fromRGB(255,255,255);
			BackgroundColor3 = Color3.fromRGB(50, 160,255);
			BorderSizePixel = 0;
		})
		whitelisttoggle.MouseButton1Click:Connect(function()
			if whiteliststatus == true then
				whiteliststatus = false
				whitelisttoggle:ChangeProperties({Text = "OFF"; BackgroundColor3 = Color3.fromRGB(255,0,0)})
			elseif whiteliststatus == false then
				whiteliststatus = true
				whitelisttoggle:ChangeProperties({Text = "ON"; BackgroundColor3 = Color3.fromRGB(0,255,0)})
			end
		end)
		nextbutton.MouseButton1Click:Connect(function()
			whitelisttoggle:Destroy()
			whitelistlabel:Destroy()
			nextbutton:Destroy()
			if whiteliststatus == true then
				storage:Write("SetupState", true)
				storage:Write("WhitelistEnabled", true)
				screen:CreateElement("TextLabel", {
					Text = "Type in anything to continue...";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BackgroundTransparency = 1;
					Size = UDim2.fromOffset(400, 25);
					Position = UDim2.fromOffset(25, 225);
				})
				keyboard:Connect("TextInputted", function(txt, plr)
					storage:Write("Whitelist", plr)
					if screen2 ~= nil then
						screen2:ClearElements()
					end
					screen:ClearElements()
					TriggerPort(5)
				end)
			else
				storage:Write("SetupState", true)
				storage:Write("WhitelistEnabled", false)
				if screen2 ~= nil then
					screen2:ClearElements()
				end
				screen:ClearElements()
				TriggerPort(5)
			end
		end)
	end
end