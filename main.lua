local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local RevealTime = 0.3
local ScanInterval = 1

local function RevealCharacter(Character)
	for _, Part in ipairs(Character:GetDescendants()) do
		if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
			if Part.Transparency > 0 then
				TweenService:Create(Part, TweenInfo.new(RevealTime), {Transparency = 0}):Play()
			end

			local Face = Part:FindFirstChild("face")
			if Face and Face.Transparency > 0 then
				TweenService:Create(Face, TweenInfo.new(RevealTime), {Transparency = 0}):Play()
			end
		elseif Part:IsA("Decal") and Part.Transparency > 0 then
			TweenService:Create(Part, TweenInfo.new(RevealTime), {Transparency = 0}):Play()
		end
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid.NameDisplayDistance = 100
	end
end

while true do
	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") and part.Transparency > 0.05 then
					RevealCharacter(char)
					break
				end
			end
		end
	end
	task.wait(ScanInterval)
end
