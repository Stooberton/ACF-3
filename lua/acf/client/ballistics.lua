ACF.BulletEffect = ACF.BulletEffect or {}

local function BulletFlight(Bullet)
	local Drag = Bullet.SimFlight:GetNormalized() *  (Bullet.DragCoef * Bullet.SimFlight:Length() ^ 2 ) / ACF.DragDiv

	Bullet.SimPosLast = Bullet.SimPos
	Bullet.SimPos = Bullet.SimPos + (Bullet.SimFlight * ACF.Scale * ACF.DeltaTime)		--Calculates the next shell position
	Bullet.SimFlight = Bullet.SimFlight + (Bullet.Accel - Drag) * ACF.DeltaTime			--Calculates the next shell vector

	if IsValid(Bullet.Effect) then
		Bullet.Effect:ApplyMovement(Bullet)
	end

	--debugoverlay.Line(Bullet.SimPosLast, Bullet.SimPos, 15, Color(255, 255, 0))
end

hook.Add("Think", "ACF_ManageBulletEffects", function()
	for Index, Bullet in pairs(ACF.BulletEffect) do
		--This is the bullet entry in the table, the omnipresent Index var refers to this
		BulletFlight(Bullet, Index)
	end
end)

ACF_SimBulletFlight = BulletFlight
