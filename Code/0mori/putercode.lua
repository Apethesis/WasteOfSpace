local screen
local function ReturnError(errorcode, errortype)
	print("An error has occured")
	if screen ~= nil then
		screen:ClearElements()
		screen:CreateElement("TextLabel",{
			Size = UDim2.fromOffset(800, 100);
			Text = "An error has occured, The error code is below and is printed to the console.";
			BackgroundTransparency = 1;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			TextScaled = true;
		})
		screen:CreateElement("TextLabel",{
			Size = UDim2.fromOffset(800, 100);
			Text = errorcode;
			BackgroundTransparency = 1;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Position = UDim2.fromOffset(0, 100);
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			TextScaled = true;
		})
		local shutdownbuttonbsod = screen:CreateElement("TextButton", {
			Size = UDim2.fromOffset(200, 50);
			Position = UDim2.fromOffset(300, 250);
			Text = "Shutdown";
			TextScaled = true;
			TextColor3 = Color3.fromRGB(0,0,0);
			BackgroundColor3 = Color3.fromRGB(100,100,100);
		})
		shutdownbuttonbsod.MouseButton1Click:Connect(function()
			screen:ClearElements()
			TriggerPort(2)
		end)
	end
	if errortype == "luaerr" then
		wait(0.5)
		Beep()
		wait(0.5)
		Beep()
		wait(0.5)
		Beep()
		wait(0.5)
		Beep()
		print(errorcode)
	end
end
local success, errorcode = pcall(function()
	local iconAmount = 0
	local modem
	local keyboard
	local speaker
	local mic
	local storage
	local rom
	local brazil
	local startmenustatus = false
	local canspawnsettings = true
	local disks
	local disksdetected
	local mounteddisks = {}
	local function CreateSelfTestOutput(text, position)
		screen:CreateElement("TextLabel", {
			Position = position;
			Size = UDim2.fromOffset(200, 25);
			Text = text;
			TextScaled = true;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextColor3 = Color3.fromHex("#FFFFFF");
			BorderSizePixel = 0;
			BackgroundTransparency = 1
		})
	end
	local function InitializeROM()
		rom:Write("PuterLibrary", {
			AddWindowElement = function(Window, Element, ElementProperties)
				local element = screen:CreateElement(Element, ElementProperties)
				Window:AddChild(element)
				return element
			end;
			PlayAudio = function(audioInputted, Speaker)
				Speaker:Configure({Audio = audioInputted})
				Speaker:Trigger()
			end;
			CreateWindow = function(x, y, temptitle, tempbackgrndcolor, temptitlebarcolor, temptextcolor)
				local backgrndcolor = Color3.fromRGB(100,100,100)
				local title = "App"
				local titlebarcolor = Color3.fromHex("#000000")
				local textcolor = Color3.fromHex("#FFFFFF")
				--basically sets the backgroundcolor of the window, if nil then it leaves the variable alone
				if tempbackgrndcolor ~= nil then
					backgrndcolor = tempbackgrndcolor
				end
				if temptitle ~= nil then
					title = temptitle
				end
				if temptitlebarcolor ~= nil then
					titlebarcolor = temptitlebarcolor
				end
				if temptextcolor ~= nil then
					textcolor = temptextcolor
				end
				--centers the window
				local posx = (800 - x) / 2
				local posy = (450 - y) / 2 - 25
				local titlebar = screen:CreateElement("TextButton", {
					Size = UDim2.fromOffset(x - 50, 50);
					Position = UDim2.fromOffset(posx, posy);
					Text = title;
					TextColor3 = textcolor;
					BackgroundColor3 = titlebarcolor;
					BorderSizePixel = 0;
					TextScaled = true;
					AutoButtonColor = false;
					ZIndex = 3;
				})
				local closebutton = screen:CreateElement("TextButton", {
					Position = UDim2.fromOffset(x - 50, 0);
					Size = UDim2.fromOffset(50, 50);
					Text = "X";
					TextColor3 = Color3.fromRGB(0,0,0);
					BackgroundColor3 = Color3.fromRGB(255,0,0);
					TextScaled = true;
					BorderSizePixel = 0;
					ZIndex = 3;
				})
				local windowframe = screen:CreateElement("Frame", {
					Size = UDim2.fromOffset(x, y);
					Position = UDim2.fromOffset(0, 50);
					BorderSizePixel = 0;
					BackgroundColor3 = backgrndcolor;
					ZIndex = 3;
				})
				titlebar:AddChild(closebutton)
				titlebar:AddChild(windowframe)
				closebutton.MouseButton1Click:Connect(function()
					titlebar:Destroy()
				end)
				titlebar.MouseButton1Click:Connect(function()
					titlebar:ChangeProperties({Position = UDim2.fromOffset(posx + 1, posy + 1)})
					titlebar:ChangeProperties({Position = UDim2.fromOffset(posx, posy)})
				end)
				return windowframe, closebutton
			end
		})
	end
	local function InitializeDesktop()
		-- Initialize the desktop (i guess)
		screen:ClearElements()
		local wallpaper = "http://www.roblox.com/asset/?id=1369437447"
		local tempwallpaper
		if storage ~= nil then
			tempwallpaper = storage:Read("Wallpaper") -- Read the wallpaper (huhh??? idk if its an id)
		end
		if tempwallpaper ~= nil then -- i knew it was an id. anyways this just checks if the temp wallpaper is something, and not nil.
			wallpaper = "http://www.roblox.com/asset/?id=" .. tostring(tempwallpaper)
		end
		-- Start painting the wallpaper
		brazil = screen:CreateElement("Frame", {
			Size = UDim2.fromOffset(800, 450);
			ZIndex = 1
		})
		local explorerApp = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(15, 15);
			Size = UDim2.fromOffset(100, 100);
			Text = "Explorer";
			TextScaled = true;
			ZIndex = 3
		})
		iconAmount = iconAmount + 1
		local background = screen:CreateElement("ImageLabel", {
			BorderSizePixel = 0;
			Image = wallpaper;
			Size = UDim2.fromOffset(800, 450);
			ZIndex = 2;
		})
		-- Paint the task bar
		local taskbar = screen:CreateElement("Frame", {
			Position = UDim2.fromOffset(0, 400);
			Size = UDim2.fromOffset(800, 50);
			BackgroundTransparency = 0.3;
			BorderSizePixel = 0;
			ZIndex = 5;
		})
		-- Paint the startbutton
		local startbutton = screen:CreateElement("TextButton", {
			Size = UDim2.fromOffset(50, 50);
			Text = "W";
			BackgroundTransparency = 0.45;
			TextColor3 = Color3.fromRGB(163, 255, 199);
			TextScaled = true;
			ZIndex = 5;
			BackgroundColor3 = Color3.fromRGB(0,0,0);
			BorderSizePixel = 0;
		})
		-- Paint the startmenu
		local startmenu = screen:CreateElement("Frame", {
			BorderSizePixel = 0;
			BackgroundTransparency = 0.3;
			ZIndex = 5;
			Position = UDim2.fromOffset(0, -250);
			Size = UDim2.fromOffset(200, 250);
			BackgroundColor3 = Color3.fromRGB(0,0,0)
		})
		-- Paint the shutdown button
		local shutdownbutton = screen:CreateElement("TextButton", {
			ZIndex = 5;
			Text = "Shutdown";
			TextScaled = true;
			BorderSizePixel = 0;
			Position = UDim2.fromOffset(10, 220);
			Size = UDim2.fromOffset(75, 20);
		})
		-- Paint the restart button
		local restartbutton = screen:CreateElement("TextButton", {
			ZIndex = 5;
			Text = "Restart";
			TextScaled = true;
			BorderSizePixel = 0;
			Position = UDim2.fromOffset(115, 220);
			Size = UDim2.fromOffset(75, 20);
		})
		-- Paint the settings button
		local settingsbutton = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(10, 10);
			Size = UDim2.fromOffset(180, 40);
			Text = "Settings";
			TextScaled = true;
		})
		-- Paint the test button
		local terminal = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(10, 60);
			Size = UDim2.fromOffset(180, 40);
			Text = "Terminal";
			TextScaled = true;
		})
		-- Add all of these items to their specific locations
		background:AddChild(taskbar)
		background:AddChild(explorerApp)
		taskbar:AddChild(startbutton)
		brazil:AddChild(startmenu)
		startmenu:AddChild(shutdownbutton)
		startmenu:AddChild(restartbutton)
		startmenu:AddChild(settingsbutton)
		startmenu:AddChild(terminal)
		-- Assign the start button to open up the start menu
		startbutton.MouseButton1Click:Connect(function()
			if startmenustatus == true then
				print("invisibling")
				brazil:AddChild(startmenu)
				startmenustatus = false
			else
				print("visibling")
				startbutton:AddChild(startmenu)
				startmenustatus = true
			end
		end)
		-- Return all of these items
		return taskbar, startmenu, startbutton, shutdownbutton, restartbutton, settingsbutton, terminal, background, explorerApp
	end
	-- Continue the init process

	-- Set some variables (for self testing)
	local importantselftest1passed = false
	local importantselftest2passed = false
	-- Get the touch screen
	screen = GetPartFromPort(1, "TouchScreen")
	-- Check if the screen is actually existing
	if screen ~= nil then
		-- We succeeded (hooray but not yet)
		-- Start the bios screen
		screen:ClearElements()
		screen:CreateElement("TextLabel", {
			Position = UDim2.fromOffset(10, 10);
			Size = UDim2.fromOffset(100, 50);
			Text = "wOS";
			TextScaled = true;
			TextColor3 = Color3.fromRGB(255,255,255);
			BackgroundTransparency = 1
		})
		CreateSelfTestOutput("Screen: OK", UDim2.fromOffset(10, 60))
		-- set the variable that the screen check is fine
		importantselftest1passed = true
	else
		screen = GetPartFromPort(1, "Screen")
		if screen ~= nil then
			print("boom")
			-- Start the bios screen
			brazil = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(800, 450)
			})
			screen:ClearElements()
			screen:CreateElement("TextLabel", {
				Position = UDim2.fromOffset(10, 10);
				Size = UDim2.fromOffset(100, 50);
				Text = "wOS";
				TextScaled = true;
				TextColor3 = Color3.fromHex("#FFFFFF");
				BackgroundTransparency = 1
			})
			CreateSelfTestOutput("Screen: OK", UDim2.fromOffset(10, 60))
			-- set the variable that the screen check is fine
			importantselftest1passed = true
		else
			print("no screen?")
			Beep()
			wait(0.5)
			Beep()
			wait(0.5)
			TriggerPort(2)
		end
	end
	-- Detect the rom and check if it exists
	rom = GetPartFromPort(6, "Disk")
	if rom ~= nil then
		print("it boot")
		InitializeROM()
		importantselftest2passed = true
	else
		print("no ROM?")
		Beep()
		wait(0.5)
		Beep()
		wait(0.5)
		Beep()
		ReturnError("ROM Missing or incorrectly attached", "hardware")
	end
	--this thing executes if the ROM disk and the TouchScreen are detected
	if importantselftest1passed == true and importantselftest2passed then
		wait(0.5)
		-- Check the keyboard
		keyboard = GetPartFromPort(1, "Keyboard")
		if keyboard ~= nil then
			CreateSelfTestOutput("Keyboard: OK", UDim2.fromOffset(10, 85))
		else
			CreateSelfTestOutput("Keyboard: NOT FOUND", UDim2.fromOffset(10, 85))
		end
		wait(0.5)
		-- Check the modem
		modem = GetPartFromPort(1, "Modem")
		if modem ~= nil then
			CreateSelfTestOutput("Modem: OK", UDim2.fromOffset(10, 110))
		else
			CreateSelfTestOutput("Modem: NOT FOUND", UDim2.fromOffset(10, 110))
		end
		wait(0.5)
		-- Check microphone
		mic = GetPartFromPort(1, "Microphone")
		if mic ~= nil then
			CreateSelfTestOutput("Microphone: OK", UDim2.fromOffset(10, 135))
		else
			CreateSelfTestOutput("Microphone: NOT FOUND", UDim2.fromOffset(10, 135))
		end
		wait(0.5)
		-- Check speaker
		speaker = GetPartFromPort(1, "Speaker")
		if speaker ~= nil then
			CreateSelfTestOutput("Speaker: OK", UDim2.fromOffset(10, 160))
		else
			CreateSelfTestOutput("Speaker: NOT FOUND", UDim2.fromOffset(10, 160))
		end
		wait(0.5)
		-- Check storage
		storage = GetPartFromPort(8, "Disk")
		if storage ~= nil then
			CreateSelfTestOutput("Storage: OK", UDim2.fromOffset(10, 185))
			if modem ~= nil then
				modem:Configure({NetworkID = storage:Read("ModemID")})
			end
		else
			CreateSelfTestOutput("Storage: NOT FOUND", UDim2.fromOffset(10, 185))
		end
		wait(0.5)
		disks = GetPartsFromPort(1, "Disk")
		local diskamount = 0
		for i, disk in pairs(disks) do
			if disk ~= nil then
				disksdetected = true
				diskamount = i
				mounteddisks["disk" .. tostring(i)] = disk
			end
		end
		CreateSelfTestOutput("Disks detected: " .. tostring(diskamount), UDim2.fromOffset(10, 210))
		wait(0.5)
		Beep()
		-- this funny thing does funny defining with the InitializeDesktop() function
		local taskbar, startmenu, startbutton, shutdownbutton, restartbutton, settingsbutton, test, background, explorerApp = InitializeDesktop()
		local puter = {
			AddWindowElement = function(Window, Element, ElementProperties)
				local element = screen:CreateElement(Element, ElementProperties)
				Window:AddChild(element)
				return element
			end;
			PlayAudio = function(audioInputted, Speaker)
				Speaker:Configure({Audio = audioInputted})
				Speaker:Trigger()
			end;
			CreateWindow = function(x, y, temptitle, tempbackgrndcolor, temptitlebarcolor, temptextcolor)
				local backgrndcolor = Color3.fromHex("#646464")
				local title = "App"
				local titlebarcolor = Color3.fromHex("#000000")
				local textcolor = Color3.fromHex("#FFFFFF")
				--basically sets the backgroundcolor of the window, if nil then it leaves the variable alone
				if tempbackgrndcolor ~= nil then
					backgrndcolor = tempbackgrndcolor
				end
				if temptitle ~= nil then
					title = temptitle
				end
				if temptitlebarcolor ~= nil then
					titlebarcolor = temptitlebarcolor
				end
				if temptextcolor ~= nil then
					textcolor = temptextcolor
				end
				--centers the window
				local posx = (800 - x) / 2
				local posy = (450 - y) / 2 - 25
				local titlebar = screen:CreateElement("TextButton", {
					Size = UDim2.fromOffset(x - 50, 50);
					Position = UDim2.fromOffset(posx, posy);
					Text = title;
					TextColor3 = Color3.fromRGB(255,255,255);
					BackgroundColor3 = titlebarcolor;
					BorderSizePixel = 0;
					TextScaled = true;
					AutoButtonColor = false;
					ZIndex = 3;
				})
				local closebutton = screen:CreateElement("TextButton", {
					Position = UDim2.fromOffset(x - 50, 0);
					Size = UDim2.fromOffset(50, 50);
					Text = "X";
					TextColor3 = Color3.fromRGB(0,0,0);
					BackgroundColor3 = Color3.fromRGB(255,0,0);
					TextScaled = true;
					BorderSizePixel = 0;
					ZIndex = 3;
				})
				local windowframe = screen:CreateElement("Frame", {
					Size = UDim2.fromOffset(x, y);
					Position = UDim2.fromOffset(0, 50);
					BorderSizePixel = 0;
					BackgroundColor3 = backgrndcolor;
					ZIndex = 3;
				})
				titlebar:AddChild(closebutton)
				titlebar:AddChild(windowframe)
				closebutton.MouseButton1Click:Connect(function()
					titlebar:Destroy()
				end)
				titlebar.MouseButton1Click:Connect(function()
					titlebar:ChangeProperties({Position = UDim2.fromOffset(posx + 1, posy + 1)})
					titlebar:ChangeProperties({Position = UDim2.fromOffset(posx, posy)})
				end)
				return windowframe, closebutton
			end;
			AddFile = function(FileType, Name, Path, Data)
				local function checkfiletype(fileType)
					if FileType == "Folder" then
						return {
							"Folder";
							{}
						}
					elseif FileType == "Image" then
						return {
							"Image";
							nil;
						}
					elseif FileType == "Text" then
						return {
							"Text";
							nil;
						}
					elseif FileType == "Audio" then
						return {
							"Text";
							nil;
						}
					else
						return {
							"Unknown";
							nil;
						}
					end
				end
				local function detectpath(path)
					local depthbuffer = {}
					local disk
					local lastpath = 1
					if string.sub(path, #path, #path) ~= "/" then
						path = path .. "/"
					end
					for i = 1, #path, 1 do
						if string.sub(path, i, i) == "/" then
							depthbuffer[#depthbuffer + 1] = string.sub(path, lastpath, i - 1)
							lastpath = i + 1
						end
					end
					return depthbuffer
				end
				local function checkpath(paths, Disk)
					local disk = mounteddisks[Disk]
					local checkeddirectory
					if disk ~= nil then
						for i, directory in pairs(paths) do
							if checkeddirectory == nil then
								checkeddirectory = disk:Read(directory)
								if checkeddirectory == nil then
									disk:Write(directory, {
										"Folder";
										{};
									})
									checkeddirectory = disk:Read(directory)
								end
							else
								if checkeddirectory[2][directory] == nil then
									checkeddirectory[2][directory] = {
										"Folder";
										{};
									}
									checkeddirectory = checkeddirectory[2][directory]
								end
							end
						end
						if checkeddirectory ~= nil then
							return checkeddirectory, disk
						end
					else
						return "No such disk"
					end
				end
				if checkfiletype(FileType) == true then
					local directory, disk = checkpath(detectpath(Path))
					local structure = checkfiletype(FileType)
					if directory ~= nil then
						directory[2][Name] = structure
					else
						disk:Write(Name, structure)
					end
				end
			end;
			ReadFile = function()
				local function detectpath(path)
					local depthbuffer = {}
					local disk
					local lastpath = 1
					if string.sub(path, #path, #path) ~= "/" then
						path = path .. "/"
					end
					for i = 1, #path, 1 do
						if string.sub(path, i, i) == "/" then
							depthbuffer[#depthbuffer + 1] = string.sub(path, lastpath, i - 1)
							lastpath = i + 1
						end
					end
					return depthbuffer
				end
				local function checkpath(paths, Disk)
					local disk = mounteddisks[Disk]
					local checkeddirectory
					if disk ~= nil then
						for i, directory in pairs(paths) do
							if checkeddirectory == nil then
								checkeddirectory = disk:Read(directory)
								if checkeddirectory == nil then
									disk:Write(directory, {
										"Folder";
										{};
									})
									checkeddirectory = disk:Read(directory)
								end
							else
								print("no such directory doofus")
							end
						end
						if checkeddirectory ~= nil then
							return checkeddirectory, disk
						end
					else
						return "No such disk"
					end
				end
			end;
		}
		shutdownbutton.MouseButton1Click:Connect(function()
			screen:ClearElements()
			Beep()
			TriggerPort(2)
		end)
		restartbutton.MouseButton1Click:Connect(function()
			screen:ClearElements()
			Beep()
			TriggerPort(3)
		end)
		local canopenexplorer = true
		explorerApp.MouseButton1Click:Connect(function()
			if canopenexplorer == true then
				local explorerwindow, closeexplorer = puter.CreateWindow(500, 225, "Explorer")
				canopenexplorer = false
				closeexplorer.MouseButton1Click:Connect(function()
					canopenexplorer = true
				end)
				local function openMainExplorer()
					for DiskName, Disk in pairs(mounteddisks) do
						local diskbutton = puter.AddWindowElement(explorerwindow, "TextButton", {
							Size = UDim2.fromOffset(125, 50);
							Text = DiskName;
						})
					end
				end
				puter.AddFile("Image", "Test", "disk1/Test/Test1/Test2", nil)
				print()
				openMainExplorer()
			end
		end)
		local cursors = {}
		screen:Connect("CursorMoved", function(cursor)
			if cursors[cursor.Player] ~= nil then
				Beep(2)
				cursors[cursor.Player]:ChangeProperties({Position = UDim2.fromOffset(cursor.X - 50, cursor.Y - 50)})
				print("New Position: " .. tostring(cursor.X - 50) .. ", " .. tostring(cursor.Y - 50))
			else
				local newCursor = screen:CreateElement("ImageLabel", {
					BackgroundTransparency = 1;
					Image = "rbxassetid://12582149183";
					Size = UDim2.fromOffset(100, 100);
					Position = UDim2.fromOffset(cursor.X - 50, cursor.Y - 50);
				})
				local playerName = screen:CreateElement("TextLabel", {
					Text = cursor.Player;
					Size = UDim2.fromOffset(200, 25);
					Position = UDim2.fromOffset(-50, -25);
					TextStrokeTransparency = 0;
					TextColor3 = Color3.fromRGB(255,255,255);
					TextScaled = true;
					BackgroundTransparency = 1;
					BorderSizePixel = 0;
				})
				print("A new player has entered the screen: " .. cursor.Player)
				newCursor:AddChild(playerName)
				cursors[cursor.Player] = newCursor
				Beep(1)
			end
		end)
		local canopenterminal = true
		test.MouseButton1Click:Connect(function()
			if canopenterminal == true then	
				local polysilicon = GetPartFromPort(7, "Polysilicon")
				local terminalmicrocontroller = GetPartFromPort(4, "Microcontroller")
				if keyboard ~= nil and terminalmicrocontroller ~= nil and polysilicon ~= nil then
					local recorded = {}
					local recordedtext = {}
					local recording = false
					local recordingtext = false
					local displayingrecmsg = false
					local displayingallmsgs = false
					local displayingalltextmsgs = false
					local displayingimg = false
					local function luarun(codetorun)
						terminalmicrocontroller:Configure({Code = codetorun})
						polysilicon:Configure({PolysiliconMode = 0})
						wait(0.5)
						TriggerPort(7)
						print(codetorun)
					end
					local function luastop()
						polysilicon:Configure({PolysiliconMode = 1})
						TriggerPort(7)
					end
					canopenterminal = false
					local test, terminalclose = puter.CreateWindow(450, 275, "Terminal", Color3.fromRGB(0,0,0))
					terminalclose.MouseButton1Click:Connect(function()
						canopenterminal = true
					end)
					puter.AddWindowElement(test, "TextLabel", {
						Size = UDim2.fromOffset(450, 25);
						Text = "wOS Codename BasicSystem, Version Alpha 1.0";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundTransparency = 1;
						TextXAlignment = Enum.TextXAlignment.Left;
					})
					local cmdline = puter.AddWindowElement(test, "TextLabel", {
						Size = UDim2.fromOffset(450, 25);
						Position = UDim2.fromOffset(0, 25);
						Text = "wOS >";
						TextScaled = true;
						TextColor3 = Color3.fromHex("#FFFFFF");
						BackgroundTransparency = 1;
						TextXAlignment = Enum.TextXAlignment.Left;
						TextYAlignment = Enum.TextYAlignment.Top;
					})
					local function terminalout(Out)
						cmdline:ChangeProperties({Text = "wOS > " .. Out})
					end
					Beep()
					local function check(text, plr)
						if string.sub(text, 1, 7) == "lua run" then
							luastop()
							luarun(string.sub(text, 9, #text))
						elseif string.sub(text, 1, 8) == "lua stop" then
							luastop()
						elseif text == "shutdown" or text == "die" then
							screen:ClearElements()
							TriggerPort(2)
						elseif text == "restart" then
							screen:ClearElements()
							TriggerPort(3)
						elseif text == "record" then
							recording = true
						elseif text == "stop recording" then
							recording = false
						elseif string.sub(text, 1, 12) == "setwallpaper" then
							local image = tostring(string.sub(text, 14, #text))
							if storage ~= nil then
								storage:Write("Wallpaper", image)
							end
							background:ChangeProperties({Image = "http://www.roblox.com/asset/?id=" .. image})
						elseif string.sub(text, 1, 21) == "play recorded message" then
							local message = recorded[tonumber(string.sub(text, 23, #text))]
							displayingrecmsg = true
							terminalout(tostring(message))
						elseif string.sub(text, 1, 17) == "play all messages" then
							if displayingallmsgs == false then
								local frame, closebutton = puter.CreateWindow(500, 225, "All Messages")
								displayingallmsgs = true
								closebutton.MouseButton1Click:Connect(function()
									displayingallmsgs = false
								end)
								local scrollingframe = puter.AddWindowElement(frame, "ScrollingFrame", {
									ScrollBarThickness = 6;
									Size = UDim2.fromOffset(500, 225);
								})
								for i, message in pairs(recorded) do
									local textlabel = puter.AddWindowElement(frame, "TextLabel", {
										Size = UDim2.fromOffset(494, 50);
										Position = UDim2.fromOffset(0, (i - 1) * 50);
										Text = message;
										TextScaled = true;
									})
									scrollingframe:ChangeProperties({CanvasSize = UDim2.fromOffset(0, i * 50)})
									scrollingframe:AddChild(textlabel)
									print(message)
								end
							end
						elseif text == "clear recorded" then
							recorded = {}
						elseif string.sub(text, 1, 10) == "play audio" then
							if speaker ~= nil then
								puter.PlayAudio(string.sub(text, 12, #text), speaker)
							end
						elseif string.sub(text, 1, 13) == "display image" then
							local image = string.sub(text, 15, #text)
							if displayingimg == false then
								local frame, closebutton = puter.CreateWindow(400, 275, "ImageViewer")
								puter.AddWindowElement(frame , "ImageLabel", {
									Image = "http://www.roblox.com/asset/?id=" .. image;
									Size = UDim2.fromOffset(400, 225);
								})
								local setwallpaper = puter.AddWindowElement(frame, "TextButton", {
									Size = UDim2.fromOffset(400, 50);
									Position = UDim2.fromOffset(0, 225);
									Text = "Set As Wallpaper";
									TextColor3 = Color3.fromHex("#FFFFFF");
									BackgroundColor3 = Color3.fromHex("#000000");
									TextScaled = true;
								})
								setwallpaper.MouseButton1Click:Connect(function()
									if storage ~= nil then
										storage:Write("Wallpaper", image)
									end
									background:ChangeProperties({Image = "http://www.roblox.com/asset/?id=" .. image})
								end)
							end
						elseif string.sub(text, 1, 10) == "setmodemid" then
							if storage ~= nil then
								storage:Write("ModemID", string.sub(text, 12, #text))
							end
							if modem ~= nil then
								modem:Configure({NetworkID = string.sub(text, 12, #text)})
							end
						elseif text == "record text" then
							recordingtext = true
						elseif text == "stop recording text" then
							recordingtext = false
						elseif string.sub(text, 1, 26) == "play recorded text message" then
							local message = recordedtext[tonumber(string.sub(text, 28, #text))]
							displayingrecmsg = true
							terminalout(tostring(message))
						elseif string.sub(text, 1, 22) == "play all text messages" then
							if displayingallmsgs == false then
								local frame, closebutton = puter.CreateWindow(500, 225, "All Text Messages")
								displayingallmsgs = true
								closebutton.MouseButton1Click:Connect(function()
									displayingallmsgs = false
								end)
								local scrollingframe = puter.AddWindowElement(frame, "ScrollingFrame", {
									ScrollBarThickness = 6;
									Size = UDim2.fromOffset(500, 225);
								})
								for i, message in pairs(recordedtext) do
									local textlabel = puter.AddWindowElement(frame, "TextLabel", {
										Size = UDim2.fromOffset(494, 50);
										Position = UDim2.fromOffset(0, (i - 1) * 50);
										Text = message;
										TextScaled = true;
									})
									scrollingframe:ChangeProperties({CanvasSize = UDim2.fromOffset(0, i * 50)})
									scrollingframe:AddChild(textlabel)
									print(message)
								end
							end
						elseif text == "clear recorded text" then
							recordedtext = {}
						elseif string.sub(text, 1, 12) == "send message" then
							local window, closebutton = puter.CreateWindow(400, 400, "Send a message to...")
							puter.AddWindowElement(window, "")
						end
					end
					keyboard:Connect("TextInputted", function(text, plr)
						if canopenterminal == false then
							text = string.sub(text, 1, #text - 1)
							terminalout(text)
							check(text)
							if recordingtext == true then
								recordedtext[#recordedtext + 1] = "[" .. plr .. "]: " .. text
							end
						end
					end)
					if mic ~= nil then
						local listeningto
						local listening = false
						mic:Connect("Chatted", function(plr, text)
							if canopenterminal == false then
								if text == "hey puter" and listening == false then
									listeningto = plr
									listening = true
									terminalout("Listening to" .. " " .. listeningto)
								elseif string.sub(text, 1, 7) == "Jarvis," then
									check(string.sub(text, 9, #text), plr)
									if displayingrecmsg == false then
										terminalout("I'm puter, but ok")
									else
										displayingrecmsg = false
									end
								elseif string.sub(text, 1, 6) == "puter," then
									check(string.sub(text, 8, #text), plr)
									if displayingrecmsg == false then
										terminalout("OK")
									else
										displayingrecmsg = false
									end
								elseif listening == true and plr == listeningto then
									check(text, plr)
									if displayingrecmsg == false then
										terminalout("OK")
									else
										displayingrecmsg = false
									end
									listening = false
									listeningto = nil
								end
								if recording == true then
									recorded[#recorded + 1] = "[" .. plr .. "]: " .. text
								end
							end
						end)
					end
				end
			end
		end)
		local canopennetworking = true
		settingsbutton.MouseButton1Click:Connect(function()
			local settingswindow
			local closebtn
			if canspawnsettings == true then
				settingswindow, closebtn = puter.CreateWindow(450, 300, "Settings", Color3.fromRGB(50,50,50))
				local networking = puter.AddWindowElement(settingswindow, "TextButton", {
					Text = "Networking";
					Position = UDim2.fromOffset(25, 25);
					Size = UDim2.fromOffset(200, 50);
					TextScaled = true;
				})
				networking.MouseButton1Click:Connect(function()
					--haha funny cat image placeholder
					local wawa
					local unwawa
					if canopennetworking == true then
						wawa = puter.AddWindowElement(settingswindow, "ImageLabel", {
							Image = "http://www.roblox.com/asset/?id=10630555127";
							Position = UDim2.fromOffset(75, 75);
							Size = UDim2.fromOffset(200, 200)
						})
						unwawa = puter.AddWindowElement(settingswindow, "TextButton", {
							Text = "Close";
							Position = UDim2.fromOffset(125, 125);
							Size = UDim2.fromOffset(200, 50);
							BackgroundColor3 = Color3.fromRGB(255,0,0);
							TextScaled = true;
						})
						canopennetworking = false
					end
					unwawa.MouseButton1Click:Connect(function()
						wawa:Destroy()
						unwawa:Destroy()
						canopennetworking = true
					end)
				end)
				canspawnsettings = false
			end
			closebtn.MouseButton1Click:Connect(function()
				canopennetworking = true
				canspawnsettings = true
			end)
		end)
		--main loop
		while true do
			wait(1)
		end
	end
end)
if success then

else
	ReturnError(errorcode, "luaerr")
end