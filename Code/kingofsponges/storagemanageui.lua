local disk = GetPartFromPort(0, "Disk")
local screen = GetPartFromPort(1, "Screen")

local resources = {}

local title = screen:CreateElement("TextLabel", {
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.75,
    Size = UDim2.new(1, 0, 0.2, 0),
    Position = UDim2.new(0, 0, 0, 0),
    Text = "RESOURCES",
    Font = Enum.Font.GothamBold 
}) 
-- i don't think we need the port_id stuff

local container = screen:CreateElement("ScrollingFrame", {
    BackgroundColor3 = Color3.new(0.15, 0.15, 0.15),
    Position = UDim2.new(0, 0, 0.2, 0),
    Size = UDim2.new(1, 0, 0.8, 0),
    CanvasSize = UDim2.new(0, 0, 2, 0),
    ScrollingDirection = Enum.ScrollingDirection.Y 
})

local resource_frame_defaults = {
    BackgroundColor3 = Color3.new(0.15, 0.15, 0.15),
    Size = UDim2.new(1, 0, 1, 0)
}

while true do
    task.wait(10)
    
