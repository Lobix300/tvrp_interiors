local interiors = {
    {
        helptext = "Appyez sur ~INPUT_CONTEXT~ pour rentrer dans le Bahamas Mamas.",
        maintext = "Bahamas Mamas",
        secondarytext = {
            text = "Entrée",
            r = 245,
            g = 80,
            b = 255,
        },
        initial = {
            x = -1388.642,
            y = -586.3759,
            z = 30.2188,
            zone = 321,
        },
        final = {
            x = -1387.484,
            y = -588.2400,
            z = 30.3195,
            h = 213.8071,
        },
        marker = {
            type = 0,
            r = 255,
            g = 18,
            b = 216,
        },
    },
    {
        helptext = "Appyez sur ~INPUT_CONTEXT~ pour sortir du Bahamas Mamas.",
        maintext = "Los Santos",
        secondarytext = {
            text = GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId()))),
            r = 93,
            g = 182,
            b = 229,
        },
        initial = {
            x = -1387.484,
            y = -588.2400,
            z = 30.3195,
            zone = 321,
        },
        final = {
            x = -1388.642,
            y = -586.3759,
            z = 30.2188,
            h = 33.9566,
        },
        marker = {
            type = 0,
            r = 255,
            g = 18,
            b = 216,
        },
    },
}

function StartTp(x, y, z, h)
    Citizen.CreateThread(function()
        isintp = true
        DoScreenFadeOut(1000)
        NetworkFadeOutEntity(PlayerPedId(), true, false)
        Wait(1000)
        infos = true
        print(infos)
        DoScreenFadeIn(0)
        SetEntityCoords(PlayerPedId(), x, y, z)
        SetEntityHeading(PlayerPedId(), h)
        Wait(2500)
        NetworkFadeInEntity(PlayerPedId(), true, false)
        Wait(500)
        infos = false
        DoScreenFadeOut(0)
        Wait(1000)
        DoScreenFadeIn(1000)
        Wait(1000)
        isintp = false
        mtext = nil
        stext = nil
        sr = nil
        sg = nil
        sb = nil
    end)
end

function MainText(text)
    Set_2dLayer(2)
    SetTextScale(0.0, 2.0)
    SetTextFont(6)
    SetTextColour(255, 255, 255, 255)
    SetTextRightJustify(1)
    SetTextWrap(0.60, 0.90)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(1.0, 0.70)
end

function SecondaryText(text)
    Set_2dLayer(2)
    SetTextScale(0.0, 2.0)
    SetTextFont(1)
    SetTextColour(sr, sg, sb, 255)
    SetTextRightJustify(1)
    SetTextWrap(0.65, 0.95)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(1.0, 0.77)
end

function HelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    DisplayHelpTextFromStringLabel(0, 0, true, -1)
end

Citizen.CreateThread(function()
    DoScreenFadeIn(0)
    while true do
        Wait(0)
        for k, v in ipairs(interiors) do
            if (GetZoneAtCoords(GetEntityCoords(PlayerPedId())) == v.initial.zone) then
                DrawMarker(v.marker.type, v.initial.x, v.initial.y, v.initial.z, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 0.75, v.marker.r, v.marker.g, v.marker.b, 220, 0, 0, 0, 0)
                if Vdist(GetEntityCoords(PlayerPedId()), v.initial.x, v.initial.y, v.initial.z) < 1 then
                    HelpText(v.helptext)
                    if IsControlJustPressed(0, 51) then
                        mtext = v.maintext
                        stext = v.secondarytext.text
                        sr = v.secondarytext.r
                        sg = v.secondarytext.g
                        sb = v.secondarytext.b
                        StartTp(v.final.x, v.final.y, v.final.z, v.final.h)
                    end
                end
            end
        end
        if infos then
            if (mtext ~= nil) then
                MainText(mtext)
            end
            if (stext ~= nil) then
                SecondaryText(stext)
            end
            DrawRect(0.0, 0.0, 2.0, 2.0, 0, 0, 0, 255)
        end
        if isintp then
            HideHudAndRadarThisFrame()
            HideHelpTextThisFrame()
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
        end
    end
end)

--UNCOMMENT THIS BLOCK TO GET YOUR CURRENT PED COORDS AND HEADING AND ZONE
--[[Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 51) then
			print("Zone : "..GetZoneAtCoords(GetEntityCoords(PlayerPedId())))
			print("X : "..GetEntityCoords(PlayerPedId()).x
            print("Y : "..GetEntityCoords(PlayerPedId()).y
            print("Z : "..GetEntityCoords(PlayerPedId()).z)
			print("H : "..GetEntityHeading(PlayerPedId()))
        end
    end
end)]]

--GO HERE TO FIND RGB COLORS
--http://www.rapidtables.com/web/color/RGB_Color.htm
