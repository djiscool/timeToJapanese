
function Initialize()



	sMeterToSetValue = SELF:GetOption('MeterToSetValue')
	
	mtMeterToSetValue = SKIN:GetMeter(sMeterToSetValue)

end -- function Initialize

function Update()
temp = os.date("*t", os.time()) 
hr = temp["hour"] 
minutes = temp["min"] 
--return(string.format("%d : %d", hr, minutes))
jTime = string.format("%s%sです", getHour(hr,0),getMin(minutes))
return(jTime)

	
end -- function Update

function getHour(hr,meridiem)
--print(hr)
Hour = ""
if hr < 13 then
	if hr == 0 then Hour = "零" --"rei"
	elseif hr == 1 then Hour = "一" --ichi"
	elseif hr == 2 then Hour = "二" --ni"
	elseif hr == 3 then Hour = "三" --san"
	elseif hr == 4 then Hour = "四" --yon"
	elseif hr == 5 then Hour = "五" --go"
	elseif hr == 6 then Hour = "六" --roku"
	elseif hr == 7 then Hour = "七" --shichi"
	elseif hr == 8 then Hour = "八" --hachi"
	elseif hr == 9 then Hour = "九" --ku"
	elseif hr == 10 then Hour = "十" --ju"
	elseif hr == 11 then Hour = "十一" --ju ichi"
	elseif hr == 12 then Hour = "十二" --ju ni"
	end
else 
	return getHour((hr - 12), 1)
end
if meridiem == 0 then return string.format("午前%s時",Hour)
elseif meridiem == 1 then return string.format("午後%s時",Hour)
else return Hour
end

end

function getMin(minutes)
if minutes == 30 then return "半分"
elseif minutes > 0 then -- exclude '分' if no minutes
	strMin = string.format("%d",minutes)
	tens = string.sub(strMin,-1) --get right most digit
	hundreds = string.sub(strMin,0,1) --get the left most digit
    
    nTens = tonumber(tens) --tens converted back to number to weed out zero, and get japanese character
	jTens = getHour(nTens, 3)
	if minutes < 10 then
	   --print(nTens)
	   return string.format("%s分", jTens) -- exclude '十' if no hundreds
	else 
	    jHundreds = getHour(tonumber(hundreds) ,3)
	    if nTens > 0 then 
		    --print("hundreds")
		    return string.format("%s十%s分",jHundreds,jTens)
        else return string.format("%s十分", jHundreds)
        end
	end	
	
else return ""
end

end

