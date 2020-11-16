function loadData()
	userData:open("r")
    --local t=string.splitS(love.math.decompress(userData,"zlib"),"\r\n")
	local t=string.splitS(userData:read(),"\r\n")
	userData:close()
	for i=1,#t do
		local i=t[i]
		if find(i,"=")then
			local t=sub(i,1,find(i,"=")-1)
			local v=sub(i,find(i,"=")+1)
			if t=="sfx"then
				setting.sfx=v=="true"
			elseif t=="bgm"then
				setting.bgm=v=="true"
			elseif t=="fullscreen"then
				setting.fullscreen=v=="true"
				love.window.setFullscreen(setting.fullscreen)
			elseif t=="lang"then
				if not Fonts[v]then v="eng"end
				setting.lang=v
				setFont=fontLib[v]
			elseif t=="mouseK"or t=="keyboardK"then
				v=toN(v)or 3
				setting[t]=v
			--Settings
			elseif t=="run"or t=="game"or t=="gametime"or t=="collect"or t=="die"then
				v=toN(v)or 0
				if v<0 then v=0 end
				stat[t]=v
			--Statistics
			elseif t=="coin"or t=="cent"or t=="diamond"then
				v=toN(v)or 0
				if v<0 then v=0 end
				data[t]=int(v)
			elseif t=="skinS"or t=="skinT"then
				v=toN(v)or 1
				data[t]=v
			elseif t=="skinAmount"then
				print(v)
				v=string.splitS(v)
				for i=1,#v do
					v[i]=toN(v[i])or 0
				end
				data.skinAmount=v
			elseif t=="HARDlock"or t=="EASIlock"or t=="INFlock"then
				data[t]=v=="true"
			elseif t=="gameunlock"then
				v=toN(v)or 0
				data[t]=int(v)
			--Data
			end
		end
	end
end
function saveData()
	local t=table.concat({
		stringPack("sfx=",setting.sfx),
		stringPack("bgm=",setting.bgm),
		stringPack("fullscreen=",setting.fullscreen),
		stringPack("lang=",setting.lang),
		stringPack("mouseK=",setting.mouseK),
		stringPack("keyboardK=",setting.keyboardK),

		stringPack("run=",stat.run),
		stringPack("game=",stat.game),
		stringPack("gametime=",stat.gametime),
		stringPack("collect=",stat.collect),
		stringPack("die=",stat.die),

		stringPack("coin=",data.coin),
		stringPack("cent=",data.cent),
		stringPack("diamond=",data.diamond),
		stringPack("skinS=",data.skinS),
		stringPack("skinT=",data.skinT),
		stringPack("skinAmount=",table.concat(data.skinAmount,"/")),
		stringPack("HARDlock=",data.HARDlock),
		stringPack("EASIlock=",data.EASIlock),
		stringPack("INFlock=",data.INFlock),
		stringPack("gameunlock=",data.gameunlock),
	},"\r\n")
	--t=love.math.compress(t,"zlib"):getString()
	userData:open("w")
	userData:write(t)
	userData:close()
end

mouseMove={}
function mouseMove.play(x,y,dx,dy,touch)
	if touchingmode and not touch then return nil end
	if pause==0 and p.alive then
		local X,Y,k=0,0
		X,Y=ms.getX()-ww*.5,ms.getY()-wh*.5
		local ax,ay=X*ctSpeed[setting.mouseK],Y*ctSpeed[setting.mouseK]
		ax,ay=max(min(ax,3),-3),max(min(ay,3),-3)
		p.vx,p.vy=p.vx+ax,p.vy+ay
		mx1,my1=mx1+ax*25,my1+ay*25
		ms.setPosition(ww*.5,wh*.5)
	end
end

mouseDown={}
function mouseDown.load(x,y,b,touch)
	if loading==4 then
		loadnum=31
		gotoScene("intro","none")
	end
end
function mouseDown.intro(x,y,b,touch)
	if touch then return nil end
	gotoScene("main","deck")
end
function mouseDown.main(x,y,b,touch)
	if abs(x-383)<13 and abs(y-256+h)<13 then v=6;SFX("eager")end
end
function mouseDown.play(x,y,b,touch)
	if pause==0 then
		if gamemode~="vs"then
			if p.alive then
				if b==1 and p.scd==0 then
					if skillList[p.skill]then
						if not skillList[p.skill]()then p.scd=p.scd0 end
					end
				elseif b==2 then
					life,bar=0,0
					die(true)
				end
			else
				if b==1 then revive()
				elseif b==2 then if life>0 then data.coin=data.coin+int(sc*.02)end restart(gamemode)
				end
			end
		elseif b==2 then
			restart(gamemode)
		end
	end
end

keyDown={}
function keyDown.intro()
	gotoScene("main","deck")
end
function keyDown.play(i)
	if i=="space"then love.mousepressed(0,0,1)
	elseif i=="z"then love.mousepressed(0,0,2)
	elseif i=="escape"then back()
	elseif i=="e"then collect=155
	elseif i=="g"then
		for i=1,8 do
			if g[1]then
				get()
				if coinMode==1 then
					stat.collect=stat.collect-1
				end
			end
		end
	elseif i=="l"and life<4 then life=life+1
	end
	if p.alive then
		if p2 then p,p2=p2,p end
		if i=="left"or i=="a"then p.vx=p.vx-2.5
		elseif i=="right"or i=="d"then p.vx=p.vx+2.5
		elseif i=="up"or i=="w"then p.vy=p.vy-3.5
		elseif i=="down"or i=="s"then p.vy=p.vy+4
		end
		if p2 then p,p2=p2,p end
	end
end

function love.mousemoved(x,y,dx,dy,touch)
	if touch then return nil end
	x,y=mouseConvert(x,y)
	mx,my=x,y
	if mouseMove[scene]then mouseMove[scene](x,y,dx,dy,touch)end

	But.sel=nil
	for i=1,#Buttons do
		local B=Buttons[i]
		if not(B.hide and B.hide())then
			if abs(x-B.x)<B.w*.5 and abs(y-B.y)<B.h*.5 then
				But.sel=B
				break
			end
		end
	end
end
function love.mousepressed(x,y,b,touch,num)
	if touch then return nil end
	x,y=mouseConvert(x,y)
	if mouseDown[scene]then mouseDown[scene](x,y,b,touch,num)end
	if b==1 then
		if not sceneSwaping and But.sel then
			local B=But.sel
			B.code()
			But.sel=nil
			love.mousemoved(ms.getX(),ms.getY())
		end
	elseif b==3 then
		back()
	end
end
function love.touchpressed(id,x,y)
	if scene=="intro"then
		touchingmode=true
		gotoScene("main","deck")
	else
		local i=#love.touch.getTouches()
		if i==1 then
			love.mousemoved(x,y)
			touching=id
		elseif i==2 then
			love.keypressed("space")
		elseif i==3
			then love.keypressed("escape")
		end
	end
end
function love.touchmoved(id,x,y,dx,dy)
	if scene=="play"then
		if id==touching and pause==0 and p.alive then
			local X,Y=dx*10,dy*10
			local ax,ay=X*ctSpeed[setting.mouseK],Y*ctSpeed[setting.mouseK]
			ax,ay=max(min(ax,3),-3),max(min(ay,3),-3)
			p.vx,p.vy=p.vx+ax,p.vy+ay
			mx1,my1=mx1*.8+X*.2,my1*.8+Y*.2
		end
	elseif #love.touch.getTouches()==1 then
		love.mousemoved(x,y)
	end
end
function love.touchreleased(id,x,y,dx,dy)
	local i=love.touch.getTouches()
	if #i==1 then
		touching=i[1]
	elseif #i==0 and scene~="play"then
		love.mousepressed(x,y,1)
		touching=nil
	end
end
function love.keypressed(i)print(ttt)
	if i=="f3"then info=not info
	elseif i=="f2"then
		setting.fullscreen=not setting.fullscreen
		love.window.setFullscreen(setting.fullscreen)
		if not setting.fullscreen then
			love.resize(gc.getWidth(),gc.getHeight())
		end
	elseif keyDown[scene]then keyDown[scene](i)
	elseif i=="escape"then back()
	end
end
function love.wheelmoved(x,y)
	if scene=="shop"then
		local i=list
		list,sel=max(min(list-sgn(y),#skin),1),1
		if i~=list then SFX("blip2")combo=0 end
	end
end


function love.draw()
	Pnt.BG[curBG]()

	if Pnt[scene]then Pnt[scene]()end
	setFont(30)
	drawButton(Buttons)
	drawCurrency[currencyDisp]()
	if mouseShow then
		local n=mouseLine:getControlPointCount()
		if n>2 then
			local L=mouseLine:render(1.5)
			local l=#L*.5-1
			for i=1,l do
				local d=i/l
				gc.setColor(1,0,0,d*.78)
				gc.setLineWidth(7*d)
				gc.line(L[2*i-1],L[2*i],L[2*i+1],L[2*i+2])
			end
			gc.setLineWidth(2)
		end
		gc.setColor(1,0,0)
		gc.circle("fill",mx,my,4)
	end--Draw fancy cursor
	if sceneSwaping then sceneSwaping.draw()end

	gc.setColor(0,0,0)
	if wh/ww>=.6 then
		gc.rectangle("fill",0,0,1000,-(wh*1000/ww-600)*.5)
		gc.rectangle("fill",0,600,1000,(wh*1000/ww-600)*.5)
	else
		gc.rectangle("fill",0,0,-(ww*600/wh-1000)*.5,600)
		gc.rectangle("fill",1000,0,(ww*600/wh-1000)*.5,600)
	end--Draw black side

	if info then
		numFont(12)
		if tm.getFPS()<60 then print(tm.getFPS(),Timer())end
		gc.print(tm.getFPS(),0,590)
		gc.print(gcinfo(),0,575)
	end
end
function love.resize(w,h)
	ww,wh=w,h
	xOy=xOy:setTransformation(w*.5,h*.5,nil,h/w>=.6 and w/1000 or h/600,nil,500,300,nil,nil)
	gc.replaceTransform(xOy)
end
function love.focus(f)
	focus=f
	if f then
		ms.setVisible(false)
		if bgmPlaying and scene~="play"then bgm[bgmPlaying]:play()end
	else
		if scene=="play"then pause=20 end
		ms.setVisible(true)
		if bgmPlaying then bgm[bgmPlaying]:pause()end
	end
end
function love.mousefocus(f)
	mouseIn=f
	if f then
		love.mousemoved(ms.getX(),ms.getY())
		for i=1,mouseLine:getControlPointCount()do
			mouseLine:removeControlPoint(1)
		end
	end
end
function love.run()
	local frameT,dt=Timer()
	tm.step()
	love.resize(1000,600)
	game.load()--Launch
	return function()
		love.event.pump()
		for name,a,b,c,d,e,f in love.event.poll()do
			if name=="quit"then
				saveData()
				return 0
			end
			love.handlers[name](a,b,c,d,e,f)
		end
		if focus or pause==20 then
			tm.step()
			dt=tm.getDelta()
			if p and p.slow then dt=dt/3;tm.sleep(.03)end
			if mouseShow then
				local i=mouseLine:getControlPointCount()
				mouseLine:insertControlPoint(mx,my,i+1)
				if i>5 then mouseLine:removeControlPoint(1)end
			end
			if sceneSwaping then
				sceneSwaping.time=sceneSwaping.time-1
				if sceneSwaping.time==sceneSwaping.mid then
					game[sceneSwaping.tar]()
					Buttons=But[scene]or But.null
					But.sel=nil
					love.mousemoved(ms.getX(),ms.getY())
				elseif sceneSwaping.time==0 then
					sceneSwaping=nil
				end
			elseif Tmr[scene]then
				Tmr[scene](dt)
			end
			if gc.isActive()then
				if FX.flash>0 then
					gc.clear(0,0,0)
					FX.flash=FX.flash-1
				else
					gc.clear(1,1,1)
					love.draw()--Draw all things
				end
				gc.present()
			end
		end
		while Timer()-frameT<1/60 do end
		frameT=Timer()
	end
end