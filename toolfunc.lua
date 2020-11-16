function max(a,b)return a>b and a or b end
function min(a,b)return b>a and a or b end
function string.splitS(s,sep)
	sep=sep or"/"
	local t={}
	repeat
		local i=find(s,sep)or #s+1
		ins(t,sub(s,1,i-1))
		s=sub(s,i+#sep)
	until #s==0
	return t
end
function stringPack(s,v)return s..toS(v)end
function sgn(i)return i>0 and 1 or -1 end
function show(str,up)ins(bonus,{Text.show[str]or str,p.x,p.y-60-(up and 30 or 0),50})end
function showText(t,x,y,f,ct0)ins(obj.text,{t=t,x=x or 500,y=y or 100,ct=ct0 or 240,f=f or 40,ct0=ct0 or 240})end
function nextLanguage()
	for i=1,#languages do
		if setting.lang==languages[i]then return languages[i+1]or"eng"end
	end
end

function setMouse(f)
	mouseShow=f
	ms.setGrabbed(not f)
end
function mouseConvert(x,y)
	if wh/ww<=.6 then
		return 500+(x-ww*.5)*600/wh,y*600/wh
	else
		return x*1000/ww,300+(y-wh*.5)*1000/ww
	end
end

function SFX(s,vol)
	if setting.sfx then
		sfx[s]:stop()
		sfx[s]:setVolume(vol or 1)
		sfx[s]:play()
	end
end
function BGM(s)
	if setting.bgm and bgmPlaying~=s then
		if bgm[bgmPlaying]then bgm[bgmPlaying]:stop()end
		if s then bgm[s]:play()end
		bgmPlaying=s
	end
end


function stencil_playground()
	gc.rectangle("fill",0,0,1000,600)
end